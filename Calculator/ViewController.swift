//
//  ViewController.swift
//  Calculator
//
//  Created by Ihor on 10.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var operation: String = ""
    var mathSign: Bool = false
    var equals: Bool = false

    @IBOutlet weak var resultNumbers: UILabel!
    @IBOutlet weak var printedNumbers: UILabel!
    
    @IBAction func digits(_ sender: UIButton) {
        if equals == true && (printedNumbers.text != "+" ||
                              printedNumbers.text != "-" ||
                              printedNumbers.text != "/" ||
                              printedNumbers.text != "×" ||
                              printedNumbers.text != "%") {
            resultNumbers.text = printedNumbers.text
            printedNumbers.text = "0"
            equals = false
        }
        
        if mathSign == true {
            printedNumbers.text = ""
            printedNumbers.text = printedNumbers.text! + String(sender.titleLabel?.text ?? "")
            //sender tag
            mathSign = false
        } else {
            if printedNumbers.text == "0" || printedNumbers.text == "" {
                printedNumbers.text = sender.titleLabel?.text ?? ""
            } else {
                printedNumbers.text?.append(sender.titleLabel?.text ?? "")
            }
        }
        firstNumber = Double(printedNumbers.text!)!
    }
    @IBAction func dot(_ sender: UIButton) {
        guard printedNumbers.text?.contains(".") == false else { return }
        printedNumbers.text?.append(".")
    }
    
    @IBAction func mathOperation(_ sender: UIButton) {
        guard printedNumbers.text != "" else { return }
        guard let text = printedNumbers.text,
              !text.isEmpty,
              let buttonText = sender.titleLabel?.text else { return }
        guard !(text.contains("+") ||
            text.contains("-") ||
            text.contains("×") ||
            text.contains("/") ||
            text.contains("%")) else { return }
        secondNumber = Double(printedNumbers.text!)!
        printedNumbers.text?.append(buttonText)
        guard let unwrappedOperation = sender.titleLabel?.text  else {return}
        operation = unwrappedOperation
        printedNumbers.text = sender.titleLabel?.text

        mathSign = true
    }
    
    @IBAction func clear(_ sender: UIButton) {
        printedNumbers.text = "0"
        resultNumbers.text = ""
        mathSign = false
        firstNumber = 0
        secondNumber = 0
    }
    
    @IBAction func equals(_ sender: UIButton) {
        equals = true
        var result: Double = 0
        if operation == "+" {
            result = secondNumber + firstNumber
        }
        else if operation == "-" {
            result = secondNumber - firstNumber
        }
        else if operation == "×" {
            result = secondNumber * firstNumber
        }
        else if operation == "/" {
            result = secondNumber / firstNumber
        }
        else if operation == "%" {
            result = secondNumber * 100 / firstNumber
        }
        
        if result.rounded(.up) == result.rounded(.down) {
            printedNumbers.text = String(format: "%g", result)
        } else {
            printedNumbers.text = String(format: "%.10g", result)
        }
    }
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var smallView: UIView!
    
    @IBOutlet weak var linkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        smallView.layer.cornerRadius = 10
        
        smallView.layer.shadowRadius = 4
        smallView.layer.shadowOpacity = 0.15
        smallView.layer.shadowOffset = CGSize(width: 0, height: 4)

//        linkButton.layer.borderWidth = 2
//        linkButton.layer.borderColor = UIColor(named: "boarder")?.cgColor
        
    }
}

