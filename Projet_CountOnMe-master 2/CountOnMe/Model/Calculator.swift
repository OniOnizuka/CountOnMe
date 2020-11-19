//
//  Calculator.swift
//  CountOnMe
//
//  Created by ONIZUKA  on 17/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {
    
    // MARK: - Properties
    weak var calculationDelegate: DisplayData?
    
    weak var errorDelegate: DisplayDataMessageError?
    
    private var calculation: String = "0" {
        didSet {
            calculationDelegate?.setDisplay(text: calculation)
        }
    }
    
    private var elements: [String] {
        calculation.split(separator: " ").map { "\($0)" }
    }
    
    private var operationsToReduce: [String] = []
    
    // Checking calculation
    private var expressionHasEnoughElement: Bool {
        elements.count >= 3
    }
    
    // Checking of adding an operand
    private var canAddOperand: Bool {
        elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
    private var expressionHasResult: Bool = false
    
    // MARK: - Internal methods
    func calculate() {
        let hasErrors = checkErrors()
        guard hasErrors == false else {
            calculation = "error"
            return
        }
        // Create local copy
        operationsToReduce = elements
        
        // Making of all divisions and multiplications
        calculatePriorOperations()
        // Repeating operations while an operand is still here
        let result = calculateAdditionAndSubstraction()
        expressionHasResult = true
        calculation = result
    }
    
    func delete() {
        // Ensuring that the calculation will not reset when taping the number Button
        expressionHasResult = false
        guard calculation != "0" else { return }
        guard let lastChar = calculation.last else { return }
        guard String(lastChar) != calculation else { return calculation = "0" }
        guard lastChar == " " else {
            calculation = String(calculation.dropLast())
            return
        }
        calculation = String(calculation.dropLast(3))
    }
    
    func resetCalculation() {
        expressionHasResult = false
        calculation = "0"
    }
    
    func addElement(_ element: String) {
        // When addind a integer we replace the initial zero
        if calculation == "0" && Int(element) != nil {
            calculation = String(calculation.dropLast())
            calculation.append(element)
        } else if Int(element) != nil {
            calculation.append(element)
        } else {
            switch element {
            case "+": addOperandToCalculation(" + ")
            case "×": addOperandToCalculation(" × ")
            case "-": addOperandToCalculation(" - ")
            case "÷": addOperandToCalculation(" ÷ ")
            default: calculation = "Unknown operand !"
            }
        }
    }
    
    func addOperandToCalculation(_ sign: String) {
        if canAddOperand {
            // Add operand
            calculation.append(sign)
        } else {
            // Replace old operand with the new one
            calculation = String(calculation.dropLast(3))
            calculation.append(sign)
        }
    }
    
    // MARK: - Private methods
    private func checkErrors() -> Bool {
        guard canAddOperand else {
            errorDelegate?.messageAlert()
            return true
        }
        guard expressionHasEnoughElement else {
            errorDelegate?.messageAlert()
            return true
        }
        return false
    }
    // Calculate all divisions and multiplications
    private func calculatePriorOperations() {
        while let priorOperandIndex = hasPriorOperation() {
            let result: String = performOperation(priorOperandIndex)
            replaceOperationByResult(priorOperandIndex - 1, result)
        }
    }
    // Checking if the calcuation get a multiplication or a divisions, if so it will return concerned operand index
    private func hasPriorOperation() -> Int? {
        
        for (index, element) in operationsToReduce.enumerated() {
            if element == "×" || element == "÷" {  return index }
        }
        return nil
    }
    
    private func performOperation(_ indexOfOperand: Int) -> String {
        let result: Float
        
        let operand: String = operationsToReduce[indexOfOperand]
        guard let left =
            Float(operationsToReduce[indexOfOperand - 1])
            else { return "error" }
        
        guard let right =
            Float(operationsToReduce[indexOfOperand + 1])
            else { return "error" }
        
        //Preventing the division starting by zero
        guard operand != "÷" || right != 0 else { return "impossible" }
        
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "÷": result = left / right
        case "×": result = left * right
        default: return "Unknown operand !"
        }
        // If a result have a decimal part the it's equal to nul that convert itself to Int
        return floor(result) == result ? String(Int(result)) : String(result)
    }
    
    private func calculateAdditionAndSubstraction() -> String {
        while operationsToReduce.count > 2 {
            let result: String = performOperation(1)
            replaceOperationByResult(0, result)
        }
        guard let result = operationsToReduce.first else { return "error" }
        return result
    }
    
    private func replaceOperationByResult(_ atIndex: Int, _ with: String) {
        for _ in 1...3 {
            operationsToReduce.remove(at: atIndex)
        }
        operationsToReduce.insert(with, at: atIndex)
    }
    
}
