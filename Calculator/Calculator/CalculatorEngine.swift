//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by Kalcsevszki Regina on 2018. 03. 13..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation

class CalculatorEngine{
    enum Number : Int {
        case Zero = 0, One = 1, Two =  2, Three = 3 ,Four = 4 ,Five = 5, Six = 6, Seven = 7, Eight = 8, Nine = 9
    }
    enum Operators {
        case Add, Substract, Multiply, Devide
    }
    
    var actualValue: Int
    var savedValue: Int
    var actualOperator: CalculatorEngine.Operators?
    
    init() {
        actualValue = 0
        savedValue = 0
    }
    
    func numberInput(number: CalculatorEngine.Number) -> Int {
        actualValue = actualValue*10 + number.rawValue
        return actualValue
    }
    
    func operatorInput(op: CalculatorEngine.Operators){
        actualOperator = op
        savedValue = actualValue
        actualValue = 0
    }
    
    func clear() -> Int{
        actualValue = 0
        savedValue = 0
        actualOperator = nil
        return actualValue
    }
    
    func equals() -> Int{
        var result : Int
        if(actualOperator != nil){
        switch actualOperator! {
        case CalculatorEngine.Operators.Add: result = savedValue + actualValue
        case CalculatorEngine.Operators.Substract: result = savedValue - actualValue
        case CalculatorEngine.Operators.Devide: result = savedValue / actualValue
        case CalculatorEngine.Operators.Multiply: result = savedValue * actualValue
            }
        } else {
            result = actualValue
        }
        clear()
        actualValue = result        
        return result
    }
    
    func getSavedValue() -> Int{
        return savedValue
    }
    
    
}
