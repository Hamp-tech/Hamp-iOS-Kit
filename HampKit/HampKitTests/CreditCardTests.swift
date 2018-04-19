//
//  CreditCardTests.swift
//  HampKitTests
//
//  Created by Aleix Baggerman on 28/02/2018.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class CreditCardTests: XCTestCase {
    
    func testCorrectCreditCard () {
        let creditCard = CreditCard.init(name: "Aleix Diaz", number: "4444444444444444",expMonth: 11, expYear: 19, cvc: "123")
        do {
            try creditCard.validate()
            XCTAssertTrue(true);
        } catch let error {
            XCTAssertTrue(false)
        }
    }
    func testMissingName () {
        let creditCard = CreditCard.init(number: "4444444444444444",expMonth: 12, expYear: 18, cvc: "123")
        
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.missingParameter("name").description)
        }
    }
    
    func testMissingNumber () {
        let creditCard = CreditCard.init(name: "Elon Musk")
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.missingParameter("number").description)
        }
    }
    
    func testIncorrectNumber () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4222 2222 2222 2")
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.numberFormatError.description)
        }
    }
    
    func testMissingYear () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511 4723 1422 9113")
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.missingParameter("year").description)
        }
    }
    
    func testInvalidYear () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511472314229113", expYear: 17)
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.invalidYear.description)
        }
    }
    
    func testMissingMonth () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511472314229113", expYear: 18)
        
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.missingParameter("month").description)
        }
    }
    
    func testIncorrectMonth () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511472314229113",expMonth: 1, expYear: 18)
        
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.invalidMonth.description)
        }
    }
    
    func testIncorrectMonthBiggerThanTwelve () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511472314229113",expMonth: 13, expYear: 19)
        
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.invalidMonth.description)
        }
    }
    
    func testMissingCVV () {
        let creditCard = CreditCard.init(name: "Elon musk", number: "4511472314229113", expMonth: 12, expYear: 18)
        
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.missingParameter("cvc").description)
        }
    }
    
    func testIncorrectCVV () {
        let creditCard = CreditCard.init(name: "Elon Musk", number: "4511472314229113", expMonth: 12, expYear: 18, cvc: "1")
        XCTAssertThrowsError(try creditCard.validate()) { (error) in
            XCTAssertEqual((error as! CreditCardError).description, CreditCardError.invalidCVV.description)
        }
    }
    
}
