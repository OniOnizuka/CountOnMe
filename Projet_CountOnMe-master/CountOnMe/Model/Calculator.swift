//
//  Calculator.swift
//  CountOnMe
//
//  Created by ONIZUKA  on 16/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {
    // MARK: - Properties
    weak var delegate: DisplayData?
    var components: [String] = [] // Array storing the needing components
    // The following elements will be used to verify numbers and operands in the calculator
    private var operandsElements: Set = ["+", "-", "*", "/"]
    private var integer: Set = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    // MARK: Computed variables
    var expression: String {
        return integer.joined().replacingOccurrences(of: ".0", with: "")
    }
    var expressionIsCorrect: Bool {
        guard components.last != nil else {
            return false
        }
        return components.count >= 3 && expressionHasOperand && !(lastElementIsOperand) && components.last != "."
            && !(integer.joined().contains("/0"))
    }
    var expressionHasOperand: Bool {
        return components.contains("+") || components.contains("-") || components.contains("*")
            || components.contains("/")
    }
    var canAddOperator: Bool {
        guard components.last != nil else {
            return false
        }
        return components.count != 0 && !operandsElements.contains(components.last!)
            && components.last != "."
    }
    var expressionHasResult: Bool {
        return components.contains("=")
    }
    var lastElementIsNumber: Bool {
        guard components.last != nil else {
            return false
        }
        if integer.contains(components.last!) {
            return true
        } else {
            return false
        }
    }
    var lastElementIsOperand: Bool {
        guard components.last != nil else {
            return false
        }
        if operandsElements.contains(components.last!) {
            return true
        } else {
            return false
        }
    }
    private var calculation: String = "0" {
        didSet {
          delegate?.setDisplay(text: calculation)
        }
    }
    var currentNumber: String { // currentNumber = elements after last operand (if one) in expression
           var currentNumberArray: [String] = components
           var operandIndices = [Int]()
           for element in currentNumberArray {
               if operandsElements.contains(element) {
                   operandIndices.append(currentNumberArray.lastIndex(of: element)!)
               }
           }
           if let operandIndex = operandIndices.max() {
               currentNumberArray.removeSubrange(0...operandIndex)
           }
           return currentNumberArray.joined()
       }
       var currentNumberHasDecimal: Bool {
           if currentNumber.contains(".") {
               return true
           } else {
               return false
           }
       }
       // MARK: Methods
       func reset() {
           components.removeAll()
           delegate?.setDisplay(text: "0")
       }
       // this func will make a number into decimal number to provide Doubles to the NSExpression for correct results
       func makeCurrentNumberDecimal() {
           guard lastElementIsNumber else {
               return
           }
           if currentNumberHasDecimal == false {
               components.append(".")
               components.append("0")
           }
       }
       func performCalcul() {
           let mathExpression = NSExpression(format: "\(components.joined())")
           var result = mathExpression.expressionValue(with: nil, context: nil) as? Double
           result = round(100 * result!)/100
           components.append("=")
           components.append("\(result!)")
           print(components)
       }
       func notifyDisplay() {
           delegate?.setDisplay(text: expression)
       }
       func correctionButton() {
           if expressionHasResult == false { // if a result is displayed, we can't correct the expression
               if components.isEmpty == false {
                   components.removeLast()
                   notifyDisplay()
               }
           }
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
        if canAddOperator {
            // add operand
            calculation.append(sign)
        } else {
            // replace old operand wuth the new
            calculation = String(calculation.dropLast(3))
            calculation.append(sign)
        }
    }

//      func numberButton(number: String) {
//            //If a result is displayed, tapping a number starts a new expression:
//            if expressionHasResult {
//                components.removeAll()
//                components.append(number)
//            } else if !(components.isEmpty && number == "0") { // a number can't start with zero
//                components.append(number)
//            }
//            notifyDisplay()
//        }
        func decimalButton() {
            if components.isEmpty {
                // if the user enters a decimal at first, we provide the zero with it:
                components.append("0")
                components.append(".")
                delegate?.setDisplay(text: expression)
            } else if lastElementIsNumber && !(currentNumberHasDecimal) {
                components.append(".")
                notifyDisplay()
            }
        }
        func operandButton(operand: String) {
            makeCurrentNumberDecimal()
            if expressionHasResult { // if there is already a result displayed, we will start a new expression with it:
                if let result = components.last {
                    components.removeAll()
                    components.append("\(result)")
                    components.append("\(operand)")
                    notifyDisplay()
                }
            } else {
                if canAddOperator {
                    components.append("\(operand)")
                    notifyDisplay()
                } else {
                    notifyDisplay()
                }
            }
        }
        func equalButton() {
            makeCurrentNumberDecimal()
            if expressionHasResult == false {
                if expressionIsCorrect {
                    performCalcul()
                    notifyDisplay()
                } else {
                    delegate?.messageAlert()
                }
            }
        }
    }
