//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTests: XCTestCase {
    let calculator = Calculator()
    var displayData: DisplayData?

    func testGivenCalculation_WhenSubstraction_ThenShowResult() {
           addCalculation("3 - 2")
        calculator.performCalcul()
        XCTAssertTrue(calculator.expression == "1")
       }

       func testGivenCalculation_WhenAddition_ThenShowResult() {
           addCalculation("3 + 2")
           calculator.performCalcul()
        XCTAssertTrue(calculator.expression == "5")
       }

       func testGivenCalculation_WhenMultiplication_ThenShowResult() {
           addCalculation("3 × 2")
           calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "6")
       }

       func testGivenCalculation_WhenDivision_ThenShowResult() {
           addCalculation("4 ÷ 2")
           calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "2")
       }

       func testGivenCalculation_WhenUsingAnotherOperand_ThenShowError() {
           addCalculation("4 / 5")
           calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "error")
       }
       // MARK: - Test Errors
       func testGivenCalculation_WhenDivisionByZero_ThenShowError() {
           addCalculation("4 ÷ 0")
            calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "impossible")
       }

       func testGivenZero_WhenAddingAnotherOperand_ThenZero() {
           addCalculation("/")
           XCTAssertFalse(calculator.expression == "Unknown operand !")
       }

       func testGivenNonNumeralElementToRight_WhenCalculate_ThenError() {
           addCalculation("A + 4")
            calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "error")
       }

       func testGivenNonNumeralElementToLeft_WhenCalculate_ThenError() {
           addCalculation("4 + B")
            calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "error")
       }

       // MARK: - Test prioritizing operations
       func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizingMultiplication() {
           addCalculation("1 + 2 × 3 + 4 × 2")
           calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "15")
       }

       func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizeDivision() {
           addCalculation("1 + 4 ÷ 2 + 4 ÷ 2")
           calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "5")
       }

       func testGivenCalculationWithMixedPriorOperandStartingWithDivision_WhenCalculate_ThenCalculateLinearly() {
           addCalculation("1 ÷ 4 × 4")
            calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "1")
       }

       func testGivenCalculationWithMixedPriorOperandStartingWithMultiplication_WhenCalculate_ThenCalculateLinearly() {
           addCalculation("1 × 4 ÷ 4")
            calculator.performCalcul()
           XCTAssertTrue(calculator.expression ==  "1")
       }

       // MARK: - Test calculation when starting with - or +
       func testGivenCalculation_WhenStartingWithPlus_ThenShowError() {
           addCalculation(" - 4 + 3")
          calculator.performCalcul()
           XCTAssertTrue(calculator.expression == "-1")
       }

       func testGivenCalculation_WhenStartingWithMinus_ThenShowError() {
           addCalculation(" + 4 + 3")
           calculator.performCalcul()
           XCTAssertTrue( calculator.expression ==  "7")
       }

       // MARK: - Test if calculation has enough element to calculate
       func testGivenCalculationWithTwoElements_WhenExpressionHasEnoughElement_ThenReturnFalse() {
           addCalculation("45")
           calculator.performCalcul()
           XCTAssertFalse( calculator.expression == "error")
       }

       // MARK: - Test canAddOperand property after each type of operand
       func testGivenCalculationEndWithPlusOperand_WhenCalculate_ThenError() {
           addCalculation("3 +")
             calculator.performCalcul()
           XCTAssertFalse( calculator.expression == "error")
       }

       func testGivenCalculationEndWithMinusOperand_WhenCalculate_ThenError() {
           addCalculation("3 -")
            calculator.performCalcul()
           XCTAssertFalse( calculator.expression == "error")
       }

       func testGivenCalculationEndWithMultiplicationOperand_WhenCalculate_ThenError() {
           addCalculation("3 ×")
            calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "error")
       }

       func testGivenCalculationEndWithDivisionOperand_WhenCalculate_ThenError() {
           addCalculation("3 ÷ ")
           calculator.performCalcul()
           XCTAssertFalse(calculator.expression == "error")
       }

       // MARK: - Test delete method
       func testGivenCalculationEndingWithInt_WhenDeleteElement_ThenCalculationWithoutLastElement() {
           addCalculation("3 + 5")
           calculator.performCalcul()
           XCTAssertEqual(calculator.expression, "3 +")
       }

       func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationWithoutLastElement() {
           addCalculation("3 + ")
            calculator.performCalcul()
           XCTAssertEqual(calculator.expression, "3")
       }

       func testGivenNothing_WhenDeleteElement_ThenKeepZero() {
         calculator.reset()
           XCTAssertEqual(calculator.expression, "0")
       }

       func testGivenCalculationWithOneElement_WhenDelete_ThenCalculationIsZero() {
           addCalculation("3")
            calculator.reset()
           XCTAssertEqual(calculator.expression, "0")
       }

       func testGivenNilElement_WhenDelete_ThenReturnNil() {
            calculator.reset()
           XCTAssertEqual(calculator.expression, "")
       }

       // MARK: - Test reset calculation
       func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationIsEmpty() {
           addCalculation("45 × 56")
           calculator.performCalcul()
           XCTAssertEqual(calculator.expression, "0")
       }

       // MARK: - Test replacing operand
       func testGivenCalculationEndingWithOperand_WhenAddOperand_ThenChangeOldOperandWithNewOperand() {
           addCalculation("45 + ")
           addCalculation("-")
           XCTAssertEqual(calculator.expression, "45 - ")
       }

       // MARK: - Methods
       override func setUp() {
           super.setUp()
           calculator.reset()
       }

       func addCalculation(_ calculation: String) {
        calculator.components.append(calculation)
       }
   }
