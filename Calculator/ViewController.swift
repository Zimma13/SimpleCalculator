//
//  ViewController.swift
//  Calculator
//
//  Created by Zimma on 13/09/2018.
//  Copyright © 2018 Zimma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResaultLbl: UILabel!
    
    var stillTyping = false
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign = ""
    var currentInput: Double {
        get {
            return Double(displayResaultLbl.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            
            if valueArray[1] == "0" {
                displayResaultLbl.text = "\(valueArray[0])"
            } else {
                displayResaultLbl.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numPressed (sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayResaultLbl.text?.count)! < 18 {
                displayResaultLbl.text = displayResaultLbl.text! + number
            }
        } else {
            displayResaultLbl.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlased = false
        
    }
    
    func operateWithTwoOperand(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlased = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperand { $0 + $1 }
        case "-":
            operateWithTwoOperand { $0 - $1 }
        case "×":
            operateWithTwoOperand { $0 * $1 }
        case "÷":
            operateWithTwoOperand { $0 / $1 }
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        operationSign = ""
        dotIsPlased = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func pesentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlased {
            displayResaultLbl.text = displayResaultLbl.text! + "."
            dotIsPlased = true
        } else if !stillTyping && !dotIsPlased {
            displayResaultLbl.text = "0."
        }
    }
    
}

