//
//  HampKitEnviromentTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 3/7/17.
//Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitEnviromentTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConstructor_FileExists() {
        let f = try! HampFile(filename: "Info", ofType: "plist")
        let e = HampEnvironment(name: "Production", file: f, apiURL : "https://hampapi.herokuapp.com/api/v1")
        XCTAssertEqual(e.name, "Production")
        XCTAssertEqual(e.file, f)
        XCTAssertEqual(e.apiURL, "https://hampapi.herokuapp.com/api/v1")
    }
    
    func testEquatable_True() {
        let f1 = try! HampFile(filename: "Info", ofType: "plist")
        let e1 = HampEnvironment(name: "Production", file: f1, apiURL : "https://hampapi.herokuapp.com/api/v1")
        
        let f2 = try! HampFile(filename: "Info", ofType: "plist")
        let e2 = HampEnvironment(name: "Production", file: f2, apiURL : "https://hampapi.herokuapp.com/api/v1")
        
        XCTAssertTrue(e1 == e2)
    }
    
    func testEquatable_False() {
        let f1 = try! HampFile(filename: "Info", ofType: "plist")
        let e1 = HampEnvironment(name: "Production", file: f1, apiURL : "https://hampapi.herokuapp.com/api/v1")
        
        let f2 = try! HampFile(filename: "Info", ofType: "plist")
        let e2 = HampEnvironment(name: "Development", file: f2, apiURL : "https://hampapi.herokuapp.com/api/v1")
        
        XCTAssertFalse(e1 == e2)
    }
}
