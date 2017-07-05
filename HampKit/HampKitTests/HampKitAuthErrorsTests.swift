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
        let error = HMPAuth.AuthError.userDisabled
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17005))
        XCTAssertEqual(error.code, 17005)
        XCTAssertEqual(error.description, "17005")
    }
    
    func testError17007() {
        let error = HMPAuth.AuthError.emailAlreadyInUse
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17007))
        XCTAssertEqual(error.code, 17007)
        XCTAssertEqual(error.description, "17007")
    }
    
    func testError17008() {
        let error = HMPAuth.AuthError.invalidEmail
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17008))
        XCTAssertEqual(error.code, 17008)
        XCTAssertEqual(error.description, "17008")
    }
    
    func testError17009() {
        let error = HMPAuth.AuthError.wrongPassword
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17009))
        XCTAssertEqual(error.code, 17009)
        XCTAssertEqual(error.description, "17009")
    }
    
    func testError17011() {
        let error = HMPAuth.AuthError.userNotFound
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17011))
        XCTAssertEqual(error.code, 17011)
        XCTAssertEqual(error.description, "17011")
    }
    
    func testError17014() {
        let error = HMPAuth.AuthError.recentLogin
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17014))
        XCTAssertEqual(error.code, 17014)
        XCTAssertEqual(error.description, "17014")
    }
    
    func testError17020() {
        let error = HMPAuth.AuthError.networkError
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17020))
        XCTAssertEqual(error.code, 17020)
        XCTAssertEqual(error.description, "17020")
    }
    
    func testError17026() {
        let error = HMPAuth.AuthError.weakPassword
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17026))
        XCTAssertEqual(error.code, 17026)
        XCTAssertEqual(error.description, "17026")
    }
    
    func testError17999() {
        let error = HMPAuth.AuthError.unknown
        XCTAssertEqual(error, HMPAuth.AuthError(rawValue: 17123))
        XCTAssertEqual(error.code, 17999)
        XCTAssertEqual(error.description, "17999")
    }
    
}
