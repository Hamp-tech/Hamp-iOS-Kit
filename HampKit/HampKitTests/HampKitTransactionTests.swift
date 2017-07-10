//
//  HampKitTransactionTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitTransactionTests: XCTestCase {
    
    var order : HampOrder!
    override func setUp() {
        super.setUp()
        order = HampOrder(smallBag: 1)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testConstructor_properties() {
        let transaction = try! HampTransaction(identifier: "123", userID: "123", cardID: "123", order: order)
        XCTAssertEqual(transaction.identifier, "123")
        XCTAssertEqual(transaction.userID, "123")
        XCTAssertEqual(transaction.cardID, "123")
    }
    
    func testConstructor_dictionary() {
        var dict = [String : Any]()
        dict[Constants.Transaction.userID] = "123"
        dict[Constants.Transaction.cardID] = "123"
        dict[Constants.Transaction.order] = order
        let transaction = try! HampTransaction(identifier: "123",properties: dict)
        
        XCTAssertEqual(transaction.identifier, "123")
        XCTAssertEqual(transaction.userID, "123")
        XCTAssertEqual(transaction.cardID, "123")
    }
    
    func testConstructor_NilDictionary() {
        let dict : [String : Any]? = nil
        XCTAssertThrowsError(try HampTransaction(identifier: "123", properties: dict))
        
    }
    
    func testConstructor_missingPropertiesUserID() {
        var dict = [String : Any]()
        dict[Constants.Transaction.cardID] = "123"
        dict[Constants.Transaction.order] = order
        
        XCTAssertThrowsError(try HampTransaction(identifier: "123", properties: dict))
    }
    
    func testConstructor_missingPropertiesCardID() {
        var dict = [String : Any]()
        dict[Constants.Transaction.userID] = "123"
        dict[Constants.Transaction.order] = order
        
        XCTAssertThrowsError(try HampTransaction(identifier: "123", properties: dict))
    }
    
    func testConstructor_missingPropertiesOrder() {
        var dict = [String : Any]()
        dict[Constants.Transaction.userID] = "123"
        dict[Constants.Transaction.cardID] = "123"
        
        XCTAssertThrowsError(try HampTransaction(identifier: "123", properties: dict))
    }
    
}
