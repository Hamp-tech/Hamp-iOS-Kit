//
//  HampManagerTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testSingleton_True() {
//        let manager = HampFir
//        let env = manager.environtment
//        XCTAssertEqual(env, try! HampEnvirontmentsProvider.productionEnvirontment())
//        XCTAssertFalse(manager.configured)
//    }
    
    func testConstructor_True() {
        let env = HampEnvironment(name: "Development", file: try! HampFile(filename: "GoogleService-Info", ofType: "plist"), apiURL : "https://hampapi.herokuapp.com/api/v1")
        let manager = HampFirebaseManager(environtment: env)
        XCTAssertEqual(env, manager.environtment)
        XCTAssertFalse(manager.configured)
    }
    
    func testConnect() {
        let env = HampEnvironment(name: "Development", file: try! HampFile(filename: "GoogleService-Info", ofType: "plist"), apiURL : "https://hampapi.herokuapp.com/api/v1")
        let manager = HampFirebaseManager(environtment: env)
        XCTAssertNoThrow(try manager.connect())
        XCTAssertThrowsError(try manager.connect())
        XCTAssertTrue(manager.configured)
        
    }
}
