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
       let calculator: Calculator = Calculator()
        // MARK: IBOutlets
        @IBOutlet weak var textView: UITextView!
        // MARK: Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            calculator.calculationDelegate = self
            textView.text = "0"
        }
        // MARK: IBActions
        @IBAction func resetButton(_ sender: UIButton) {
            calculator.resetCalculation()
        }
        @IBAction func tappedCorrectionButton(_ sender: UIButton) {
            calculator.delete()
        }
        @IBAction func tappedNumberButton(_ sender: UIButton) {
            guard let numberButton = sender.title(for: .normal) else { return }
            calculator.addElement(numberButton)
        }
        @IBAction func tappedOperandButton(_ sender: UIButton) {
            guard let operandButton = sender.title(for: .normal) else {  return }
            calculator.addElement(operandButton)
        }
        @IBAction func tappedEqualButton(_ sender: UIButton) {
            calculator.calculate()
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
