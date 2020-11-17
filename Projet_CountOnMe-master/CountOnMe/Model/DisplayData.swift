//
//  DisplayData.swift
//  CountOnMe
//
//  Created by ONIZUKA  on 16/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Using Delegate Protocol to send data to the View Controller
protocol DisplayData: class {
    func setDisplay(text: String)
    func messageAlert()
}
