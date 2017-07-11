//
//  HampKitUserTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 11/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit
class HampKitUserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor_properties() {
        let user = try! HampUser(identifier: "123",
                            name: "John",
                            surname: "Appleseed",
                            mail: "john@apple.com",
                            phone: "666666666",
                            birthday: Date().iso8601(),
                            gender: "M",
                            tokenFCM: "123",
                            language: "es-Ca",
                            OS: "iOS",
                            signupDate: Date().iso8601())
        XCTAssertEqual(user.identifier, "123")
        XCTAssertEqual(user.name, "John")
        XCTAssertEqual(user.surname, "Appleseed")
        XCTAssertEqual(user.phone, "666666666")
        XCTAssertEqual(user.gender, "M")
        XCTAssertEqual(user.tokenFCM, "123")
        XCTAssertEqual(user.language, "es-Ca")
        XCTAssertEqual(user.os, "iOS")
    }
    
    func testConstructor_dictionary() {
        var dict = [String : Any]()
        dict[Constants.User.name] = "John"
        dict[Constants.User.surname] = "Appleseed"
        dict[Constants.User.mail] = "john@apple.com"
        dict[Constants.User.phone] = "666666666"
        
        let user = try! HampUser(identifier: "123", properties: dict)
        XCTAssertEqual(user.identifier, "123")
        XCTAssertEqual(user.name, "John")
        XCTAssertEqual(user.surname, "Appleseed")
        XCTAssertEqual(user.phone, "666666666")
        XCTAssertNil(user.birthday)
    }
    
}
