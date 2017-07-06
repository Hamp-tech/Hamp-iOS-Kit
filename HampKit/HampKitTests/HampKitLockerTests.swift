//
//  HampKitLockerTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 6/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest

class HampKitLockerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor_OnlyIdentifier() {
        let locker = HampLocker(identifier: "1234")
        XCTAssertEqual(locker.identifier, "1234")
        XCTAssertFalse(locker.booked)
        XCTAssertEqual(locker.lockerID, "")
        XCTAssertEqual(locker.secretKey, "")
    }
    
    func testConstructor_properties_bookedFalse() {
        let locker = HampLocker(identifier: "1234", booked: false, lockerID: "1234", secretKey: "1234")
        XCTAssertEqual(locker.identifier, "1234")
        XCTAssertFalse(locker.booked)
        XCTAssertEqual(locker.lockerID, "1234")
        XCTAssertEqual(locker.secretKey, "1234")
    }
    
    func testConstructor_properties_bookedTrue() {
        let locker = HampLocker(identifier: "1234", booked: true, lockerID: "1234", secretKey: "1234")
        XCTAssertEqual(locker.identifier, "1234")
        XCTAssertTrue(locker.booked)
        XCTAssertEqual(locker.lockerID, "1234")
        XCTAssertEqual(locker.secretKey, "1234")
    }
    
    func testConstructor_propertiesFromDictionary() {
        var dict = [String : Any]()
        dict[Constants.Locker.booked] = true
        dict[Constants.Locker.lockerID] = "1234"
        dict[Constants.Locker.secretKey] = "1234"
        let locker = HampLocker(identifier: "1234", properties: dict)
        
        XCTAssertEqual(locker.identifier, "1234")
        XCTAssertTrue(locker.booked)
        XCTAssertEqual(locker.lockerID, "1234")
        XCTAssertEqual(locker.secretKey, "1234")
    }
    
    func testConstructor_propertiesFromNilDictionary() {
        let dict : [String : Any]? = nil
        let locker = HampLocker(identifier: "1234", properties: dict)
        
        XCTAssertEqual(locker.identifier, "1234")
    }
    
    
}
