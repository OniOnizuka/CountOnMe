//
//  CalculatorDelegate.swift
//  CountOnMeTests
//
//  Created by ONIZUKA  on 17/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe
class CalculatorDelegateTests: DisplayData {
     var mockCalculation: String = "0"
    func setDisplay(text: String) {
        mockCalculation = text
    }
}
