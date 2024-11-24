//
//  ViewController.swift
//  Calculator
//
//  Created by Furkan Türkyaşar on 22.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    
    var currentNumber: String = ""
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var currentOperation: String = ""
    var isPerformingOperation: Bool = false
    var isSummed: Bool = false
    var hasComma: Bool = false
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if let number = sender.titleLabel?.text {
            
            if isSummed {
                currentNumber = number
                isSummed = false
            } else {
                if isPerformingOperation {
                    currentNumber = number
                    isPerformingOperation = false
                } else {
                    currentNumber += number
                }
            }
            
            if currentNumber.starts(with: "0") {
                currentNumber = String(currentNumber.split(separator: "0").last.map(String.init) ?? "0")
            }
            resultLabel.text = currentNumber
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        
        switch sender.tag {
            case 1:
                currentOperation = "-"
            case 2:
                currentOperation = "+"
            case 3:
                currentOperation = "*"
            case 4:
                currentOperation = "/"
            case 5:
                currentOperation = "%"
            default:
                break
        }
        
        if isSummed {
            if let number = resultLabel.text {
                firstOperand = Double(number) ?? 0
            }
            isSummed = false
        } else {
            if !currentNumber.isEmpty {
                firstOperand = Double(currentNumber) ?? 0
            }
        }
        currentNumber = ""
        isPerformingOperation = true
    }
    
    @IBAction func sumPressed(_ sender: UIButton) {
        if !currentNumber.isEmpty {
            secondOperand = Double(currentNumber) ?? 0
            var result: Double = 0
            
            switch currentOperation {
                case "-":
                    result = firstOperand - secondOperand
                case "+":
                    result = firstOperand + secondOperand
                case "*":
                    result = firstOperand * secondOperand
                case "/":
                    result = firstOperand / secondOperand
                case "%":
                    result = firstOperand.truncatingRemainder(dividingBy: secondOperand)
                default:
                    break
            }
            
            resultLabel.text = result == floor(result) ? String(Int(result)) : String(result)
            isSummed = true
            hasComma =  false
        }
    }
    
    @IBAction func commaPressed(_ sender: UIButton) {
        
        if isPerformingOperation {
            currentNumber = "0."
        } else {
            if hasComma {
                currentNumber.removeLast()
            } else {
                currentNumber += "."
            }
        }
        resultLabel.text = currentNumber
        hasComma = !hasComma
    }
    
    @IBAction func transformPessed(_ sender: UIButton) {
        var number = Double(currentNumber) ?? 0
        
        let alert = UIAlertController(title: "Error", message: "You can not transform a zero number", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        
        guard number != 0 else {return self.present(alert, animated: true, completion: nil)}
        
        number = -number
        currentNumber = String(number)
        resultLabel.text = number == floor(number) ? String(Int(number)) : String(number)
    }
    
    func reset(to number: String = "") {
        currentNumber = number
        firstOperand = 0
        secondOperand = 0
        currentOperation = ""
        isPerformingOperation = false
        resultLabel.text = "0"
        hasComma = false
        isSummed = false
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        
        if currentNumber != "" {
            if hasComma {
                commaPressed(UIButton())
            } else {
                if isSummed {
                    currentNumber = "0"
                } else {
                    currentNumber.removeLast()
                }
                
                if currentNumber == "" {
                    reset(to: "0")
                }
                resultLabel.text = currentNumber
            }
        } else {
            reset()
        }
        
    }
    
}

