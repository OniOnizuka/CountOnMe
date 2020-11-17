//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
        private let calculator = Calculator()
        // MARK: IBOutlets
        @IBOutlet weak var textView: UITextView!
        // MARK: Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            calculator.delegate = self
            textView.text = "0"
        }
        // MARK: IBActions
        @IBAction func resetButton(_ sender: UIButton) {
            calculator.reset()
        }
        @IBAction func tappedCorrectionButton(_ sender: UIButton) {
            calculator.correctionButton()
        }
        @IBAction func tappedNumberButton(_ sender: UIButton) {
            guard let numberButton = sender.title(for: .normal) else { return }
            calculator.addElement(numberButton)
        }
        @IBAction func tappedDecimalButton(_ sender: UIButton) {
            calculator.decimalButton()
        }
        @IBAction func tappedOperandButton(_ sender: UIButton) {
            guard let operandButton = sender.title(for: .normal) else {  return }
            calculator.operandButton(operand: operandButton)
        }
        @IBAction func tappedEqualButton(_ sender: UIButton) {
            calculator.equalButton()
        }
    }
    // MARK: Extension
    extension ViewController: DisplayData {
         func setDisplay(text: String) {
            textView.text = text
        }
        func messageAlert() {
            let alertVC = UIAlertController(title: "Erreur", message:
                "Veuillez entrer une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }
