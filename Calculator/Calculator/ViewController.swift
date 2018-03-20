//
//  ViewController.swift
//  Calculator
//
//  Created by Kalcsevszki Regina on 2018. 03. 13..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculator : CalculatorEngine = CalculatorEngine()
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var SubstractButton: UIButton!
    @IBOutlet weak var MultiplyButton: UIButton!
    @IBOutlet weak var DevideButton: UIButton!
    
    var selectedButton : UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AddButton.layer.cornerRadius = 0.5 * AddButton.bounds.size.width;
        SubstractButton.layer.cornerRadius = 0.5 * SubstractButton.bounds.size.width;
        MultiplyButton.layer.cornerRadius = 0.5 * MultiplyButton.bounds.size.width;
        DevideButton.layer.cornerRadius = 0.5 * DevideButton.bounds.size.width;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ZeroButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Zero))
    }
    @IBAction func OneButtonClick(_ sender: Any) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.One))
    }
    @IBAction func TwoButtonClick(_ sender: Any) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Two))
    }
    @IBAction func ThreeButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Three))
    }
    @IBAction func FourBittonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Four))
    }
    @IBAction func FiveButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Five))
    }
    @IBAction func SixButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Six))
    }
    @IBAction func SevenButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Seven))
    }
    @IBAction func EigthButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Eight))
    }
    @IBAction func NineButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.numberInput(number: CalculatorEngine.Number.Nine))
    }
    
    @IBAction func ClearButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.clear())
    }
    @IBAction func EqualsButtonClick(_ sender: UIButton) {
        resultLabel.text = String(calculator.equals())
        operatorLabel.text = " "
        operandLabel.text = " "
    }
    
    @IBAction func PlusButtonClick(_ sender: UIButton) {
        calculator.operatorInput(op: CalculatorEngine.Operators.Add)
        operatorLabel.text = "+"
        operandLabel.text = String(calculator.getSavedValue())
        selectedButton?.backgroundColor = UIColor.darkGray
        selectedButton = AddButton
        selectedButton?.backgroundColor = UIColor.blue
    }
    @IBAction func MinusButtonClick(_ sender: UIButton) {
        calculator.operatorInput(op: CalculatorEngine.Operators.Substract)
        operatorLabel.text = "-"
        operandLabel.text = String(calculator.getSavedValue())
        selectedButton?.backgroundColor = UIColor.darkGray
        selectedButton = SubstractButton
        selectedButton?.backgroundColor = UIColor.blue

    }
    @IBAction func MultiplyButtonClick(_ sender: UIButton) {
        calculator.operatorInput(op: CalculatorEngine.Operators.Multiply)
        operatorLabel.text = "*"
        operandLabel.text = String(calculator.getSavedValue())
        selectedButton?.backgroundColor = UIColor.darkGray
        selectedButton = MultiplyButton
        selectedButton?.backgroundColor = UIColor.blue

    }
    @IBAction func DevideButtonClick(_ sender: UIButton) {
        calculator.operatorInput(op: CalculatorEngine.Operators.Devide)
        operatorLabel.text = "/"
        operandLabel.text = String(calculator.getSavedValue())
        selectedButton?.backgroundColor = UIColor.darkGray
        selectedButton = DevideButton
        selectedButton?.backgroundColor = UIColor.blue

    }
    
    
}

