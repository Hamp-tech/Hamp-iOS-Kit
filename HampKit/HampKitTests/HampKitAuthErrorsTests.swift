//
//  HampKitAuthErrorsTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest

class HampKitAuthErrorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testError17005() {
        let error = HampFirebaseAuth.AuthResponseError.userDisabled
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17005))
        XCTAssertEqual(error.code, 17005)
        XCTAssertEqual(error.description, "17005")
    }
    
    func testError17007() {
        let error = HampFirebaseAuth.AuthResponseError.emailAlreadyInUse
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17007))
        XCTAssertEqual(error.code, 17007)
        XCTAssertEqual(error.description, "17007")
    }
    
    func testError17008() {
        let error = HampFirebaseAuth.AuthResponseError.invalidEmail
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17008))
        XCTAssertEqual(error.code, 17008)
        XCTAssertEqual(error.description, "17008")
    }
    
    func testError17009() {
        let error = HampFirebaseAuth.AuthResponseError.wrongPassword
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17009))
        XCTAssertEqual(error.code, 17009)
        XCTAssertEqual(error.description, "17009")
    }
    
    func testError17011() {
        let error = HampFirebaseAuth.AuthResponseError.userNotFound
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17011))
        XCTAssertEqual(error.code, 17011)
        XCTAssertEqual(error.description, "17011")
    }
    
    func testError17014() {
        let error = HampFirebaseAuth.AuthResponseError.recentLogin
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17014))
        XCTAssertEqual(error.code, 17014)
        XCTAssertEqual(error.description, "17014")
    }
    
    func testError17020() {
        let error = HampFirebaseAuth.AuthResponseError.networkError
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17020))
        XCTAssertEqual(error.code, 17020)
        XCTAssertEqual(error.description, "17020")
    }
    
    func testError17026() {
        let error = HampFirebaseAuth.AuthResponseError.weakPassword
        XCTAssertEqual(error, HampFirebaseAuth.AuthResponseError(rawValue: 17026))
        XCTAssertEqual(error.code, 17026)
        XCTAssertEqual(error.description, "17026")
    }
    
}
