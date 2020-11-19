//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by ONIZUKA  on 18/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTests: XCTestCase  {
    
     // MARK: - Property
    let calculator = Calculator()
    var displayData = CalculatorDelegateTests()
    
    // MARK: - Test calculation with each type of operand
    func testGivenCalculation_WhenSubstraction_ThenShowResult() {
        addCalculation("3 - 2")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation, "1")
    }
    
    func testGivenCalculation_WhenAddition_ThenShowResult() {
        addCalculation("3 + 2")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation == "5")
    }
    
    func testGivenCalculation_WhenMultiplication_ThenShowResult() {
        addCalculation("3 × 2")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation == "6")
    }
    
    func testGivenCalculation_WhenDivision_ThenShowResult() {
        addCalculation("4 ÷ 2")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation == "2")
    }
    
    func testGivenCalculation_WhenUsingAnotherOperand_ThenShowError() {
        addCalculation("4 / 5")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation, "error")
    }
    // MARK: - Test Errors
    func testGivenCalculation_WhenDivisionByZero_ThenShowError() {
        addCalculation("4 ÷ 0")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation,"impossible")
    }
    
    func testGivenZero_WhenAddingAnotherOperand_ThenZero() {
        addCalculation("/")
        XCTAssertEqual(displayData.mockCalculation,"Unknown operand !")
    }
    
    func testGivenNonNumeralElementToRight_WhenCalculate_ThenError() {
        addCalculation("A + 4")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation,"error")
    }
    
    func testGivenNonNumeralElementToLeft_WhenCalculate_ThenError() {
        addCalculation("4 + B")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation, "error")
    }
    
    // MARK: - Test prioritizing operations
    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizingMultiplication() {
        addCalculation("1 + 2 × 3 + 4 × 2")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation,"15")
    }
    
    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizeDivision() {
        addCalculation("1 + 4 ÷ 2 + 4 ÷ 2")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation,"5")
    }
    
    func testGivenCalculationWithMixedPriorOperandStartingWithDivision_WhenCalculate_ThenCalculateLinearly() {
        addCalculation("1 ÷ 4 × 4")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation == "1")
    }
    
    func testGivenCalculationWithMixedPriorOperandStartingWithMultiplication_WhenCalculate_ThenCalculateLinearly() {
        addCalculation("1 × 4 ÷ 4")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation ==  "1")
    }
    
    // MARK: - Test calculation when starting with - or +
    func testGivenCalculation_WhenStartingWithPlus_ThenShowError() {
        addCalculation(" - 4 + 3")
        calculator.calculate()
        XCTAssertTrue(displayData.mockCalculation == "-1")
    }
    
    func testGivenCalculation_WhenStartingWithMinus_ThenShowError() {
        addCalculation(" + 4 + 3")
        calculator.calculate()
        XCTAssertTrue( displayData.mockCalculation ==  "7")
    }
    
    // MARK: - Test if calculation has enough element
    func testGivenCalculationWithTwoElements_WhenExpressionHasEnoughElement_ThenReturnFalse() {
        addCalculation("45")
        calculator.calculate()
        XCTAssertEqual( displayData.mockCalculation, "error")
    }
    
    // MARK: - Test canAddOperand
    func testGivenCalculationEndWithPlusOperand_WhenCalculate_ThenError() {
        addCalculation("3 +")
        calculator.calculate()
        XCTAssertEqual( displayData.mockCalculation, "error")
    }
    
    func testGivenCalculationEndWithMinusOperand_WhenCalculate_ThenError() {
        addCalculation("3 -")
        calculator.calculate()
        XCTAssertEqual( displayData.mockCalculation, "error")
    }
    
    func testGivenCalculationEndWithMultiplicationOperand_WhenCalculate_ThenError() {
        addCalculation("3 ×")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation, "error")
    }
    
    func testGivenCalculationEndWithDivisionOperand_WhenCalculate_ThenError() {
        addCalculation("3 ÷ ")
        calculator.calculate()
        XCTAssertEqual(displayData.mockCalculation, "error")
    }
    
    // MARK: - Test delete method
    func testGivenCalculationEndingWithInt_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + 5")
        calculator.delete()
        XCTAssertEqual(displayData.mockCalculation, "3 + ")
    }
    
    func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + ")
        calculator.delete()
        XCTAssertEqual(displayData.mockCalculation, "3")
    }
    
    func testGivenNothing_WhenDeleteElement_ThenKeepZero() {
        calculator.delete()
        XCTAssertEqual(displayData.mockCalculation, "0")
    }
    
    func testGivenCalculationWithOneElement_WhenDelete_ThenCalculationIsZero() {
        addCalculation("3")
        calculator.delete()
        XCTAssertEqual(displayData.mockCalculation, "0")
    }
    
    func testGivenNilElement_WhenDelete_ThenReturnNil() {
        displayData.mockCalculation = ""
        calculator.delete()
        XCTAssertEqual(displayData.mockCalculation, "")
    }
    
    // MARK: - Test reset calculation
    func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationIsEmpty() {
        addCalculation("45 × 56")
        calculator.resetCalculation()
        XCTAssertEqual(displayData.mockCalculation, "0")
    }
    
    // MARK: - Test replacing operand
    func testGivenCalculationEndingWithOperand_WhenAddOperand_ThenChangeOldOperandWithNewOperand() {
        addCalculation("45 + ")
        addCalculation("-")
        XCTAssertEqual(displayData.mockCalculation, "45 - ")
    }
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        calculator.resetCalculation()
        calculator.calculationDelegate = displayData
    }
    
    func addCalculation(_ calculation: String) {
        let elements: [String] = calculation.split(separator: " ").map { "\($0)" }
        elements.forEach({ element in
            calculator.addElement(element)
        })
    }
}
