//
//  CalculatorDelegateMock.swift
//  CountOnMeTests
//
//  Created by ONIZUKA  on 16/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe

class CalculatorDelegateMock: DisplayData {
    func messageAlert() {
    }
    var mockCalculation: String = "0"
    func setDisplay(text: String) {
         mockCalculation = text
        }
    }
