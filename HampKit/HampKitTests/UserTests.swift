//
//  UserTests.swift
//  HampiOSKitTests
//
//  Created by Joan Molinas Ramon on 25/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class UserTests: XCTestCase {
    
    func testSuccessfulUser() {
        // TODO: When all validations will be done, do it.
    }
    
    func testMissingName() {
        let user = User()
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("name").description)
        }
    }
    
    func testMissingSurname() {
        let user = User(name: "Elon")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("surname").description)
        }
    }
    
    func testMissingEmail() {
        let user = User(name: "Elon", surname: "Musk")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("email").description)
        }
    }
    
    func testWrongEmail() {
        let user = User(name: "Elon", surname: "Musk", email: "SpaceX")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("email").description)
        }
    }
    
    func testValidEmail() {
        let user = User(name: "Elon", surname: "Musk", email: "elon@usehamp.io")
        do {
            try user.validate()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
}
