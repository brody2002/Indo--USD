//
//  MoneyCalculator.swift
//  IndoCashConverter
//
//  Created by Brody on 1/8/25.
//

import Foundation

struct MoneyCalculator{
    
    func americanToIndo(_ inputAmerican: String) -> Double {
        let americanValue: Double = Double(inputAmerican) ?? 0.0
        let indoValue: Double = americanValue * 16143.01
        return indoValue
    }
    
    func indoToAmerican(_ inputIndo: String) -> Double {
        let indoValue: Double = Double(inputIndo) ?? 0.0
        let americanValue: Double = indoValue / 16143.01
        return americanValue
    }
}
