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
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@userhamp.io", password: "123123", phone: "666666666", birthday: "1994-11-07T13:15:30Z", gender: "M")
        do {
            try user.validate()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
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
            XCTAssertEqual((error as! UserError).description, UserError.emailFormatError.description)
        }
    }
        
    func testWrongPassword () {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@usehamp.io", password: "")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("password").description)
        }
    }
    
    func testMissingPhone () {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@usehamp.io", password: "123123")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("phone").description)
        }
    }
    
    func testWrongPhone () {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@userhamp.io", password: "123123", phone: "66666666")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.phoneFormatError.description)
        }
    }
    
    func testWrongPhoneNumber() {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@userhamp.io", password: "123123", phone: "123456789")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.phoneFormatError.description)
        }
    }
    
    //1994-11-07T13:15:30Z
    func testMissingBirthday () {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@usehamp.io", password: "123123", phone: "666666666")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("birthday").description)
        }
    }
    
    func testMissingGender () {
        let user = User.init(name: "Elon", surname: "Musk", email: "elon@usehamp.io", password: "123123", phone: "666666666", birthday: "1994-11-07T13:15:30Z")
        XCTAssertThrowsError(try user.validate()) { (error) in
            XCTAssertEqual((error as! UserError).description, UserError.missingParameter("gender").description)
        }
    }
    
}
