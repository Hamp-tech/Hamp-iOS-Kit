//
//  HampKitCreditCardTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitCreditCardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor_properties_emptyCard() {
        let creditCard = HampCreditCard.init()
        XCTAssertNil(creditCard.identifier)
        XCTAssertNil(creditCard.number)
        XCTAssertNil(creditCard.name)
        XCTAssertNil(creditCard.month)
        XCTAssertNil(creditCard.year)
        XCTAssertNil(creditCard.cvv)
    }
    
    func testConstructor_properties() {
        let creditCard = try! HampCreditCard(identifier: "123",
                                             number: "4111111111111111",
                                             name: "John applesseed",
                                             month: "12",
                                             year: "21",
                                             cvv: "123")
        XCTAssertEqual(creditCard.identifier, "123")
        XCTAssertEqual(creditCard.number, "4111111111111111")
        XCTAssertEqual(creditCard.name, "John applesseed")
        XCTAssertEqual(creditCard.month, "12")
        XCTAssertEqual(creditCard.year, "21")
        XCTAssertEqual(creditCard.cvv, "123")
    }
    
    func testConstructor_dictionary() {
        var dict = [String : Any]()
        dict[Constants.CreditCard.number] = "4111111111111111"
        dict[Constants.CreditCard.name] = "John applesseed"
        dict[Constants.CreditCard.month] = "12"
        dict[Constants.CreditCard.year] = "21"
        dict[Constants.CreditCard.cvv] = "123"
        
        let creditCard = try! HampCreditCard(identifier: "123", properties: dict)
        
        XCTAssertEqual(creditCard.identifier, "123")
        XCTAssertEqual(creditCard.number, "4111111111111111")
        XCTAssertEqual(creditCard.month, "12")
        XCTAssertEqual(creditCard.year, "21")
        XCTAssertEqual(creditCard.cvv, "123")
    }
    
    func testConstructor_Nildictionary() {
        let dict : [String : Any]? = nil
        XCTAssertThrowsError(try HampCreditCard(identifier: "123", properties: dict))
    }
    
    func testConstructor_dictionary_errorNumber() {
        var dict = [String : Any]()
        dict[Constants.CreditCard.number] = "411111111111111"
        dict[Constants.CreditCard.name] = "John applesseed"
        dict[Constants.CreditCard.month] = "12"
        dict[Constants.CreditCard.year] = "21"
        dict[Constants.CreditCard.cvv] = "123"
        
        XCTAssertThrowsError(try HampCreditCard(identifier: "123", properties: dict))
    }
    
    func testConstructor_properties_nilIdentifier() {
        let creditCard = try! HampCreditCard(identifier: nil,
                                             number: "4111111111111111",
                                             name: "John appleseed",
                                             month: "12",
                                             year: "21",
                                             cvv: "123")
        
        XCTAssertNil(creditCard.identifier)
        XCTAssertEqual(creditCard.number, "4111111111111111")
        XCTAssertEqual(creditCard.number, "4111111111111111")
        XCTAssertEqual(creditCard.month, "12")
        XCTAssertEqual(creditCard.year, "21")
        XCTAssertEqual(creditCard.cvv, "123")
    }
    
    func testConstructor_properties_number() {
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "411111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "999")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidNumber)
        }
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "41111111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidNumber)
        }
    }
    
    func testConstructor_properties_month() {
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "0",
                year: "21",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidMonth)
        }
        
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "13",
                year: "21",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidMonth)
        }
        
        XCTAssertNoThrow(
            try HampCreditCard(
            identifier: "123",
            number: "4111111111111111",
            name: "John appleseed",
            month: "5",
            year: "21",
            cvv: "123"))
        
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "5",
                year: "17",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidMonth)
        }
    }
    
    func testConstructor_properties_year() {
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "12",
                year: "16",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidYear)
        }
    }
    
    func testConstructor_properties_cvv() {
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidCVV)
        }
        
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "0")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidCVV)
        }
        
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "00")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidCVV)
        }
        
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "John appleseed",
                month: "12",
                year: "21",
                cvv: "0000")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidCVV)
        }
    }
    
    func testConstructor_properties_name() {
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "",
                month: "12",
                year: "21",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidName)
        }
        XCTAssertThrowsError(
            try HampCreditCard(
                identifier: "123",
                number: "4111111111111111",
                name: "   ",
                month: "12",
                year: "21",
                cvv: "123")) { (error) in
                    XCTAssertEqual(error as? HampCreditCard.CreditCardError, HampCreditCard.CreditCardError.invalidName)
        }
    }
}




