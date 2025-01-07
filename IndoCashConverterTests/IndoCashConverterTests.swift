//
//  IndoCashConverterTests.swift
//  IndoCashConverterTests
//
//  Created by Brody on 1/7/25.
//

import XCTest
@testable import IndoCashConverter

final class IndoCashConverterTests: XCTestCase {
    let moneyCalculate = MoneyCalculator()
    
    func testAmericanToIndoConversion(){
        let usdInput = "32.00"
        let expectedAnswer: Double = 516576.32
        let indoOutput = moneyCalculate.americanToIndo(usdInput)

        XCTAssertEqual(expectedAnswer, indoOutput, accuracy: 0.01, "Conversion output does not match expected result.")
    }
    
    func testIndoToAmericanConverstion() {
        let indoInput = "1000000.00"
        let expectedAnswer: Double = 16143010000
        let americanOutput = moneyCalculate.indoToAmerican(indoInput)
        
        XCTAssertEqual(expectedAnswer, americanOutput, accuracy: 0.01, "Converstion output does not match expected result")
        
    }
}
