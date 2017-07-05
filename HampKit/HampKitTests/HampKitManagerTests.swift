//
//  HMPManagerTests.swift
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
    
    func testSingleton_True() {
        let manager = HMPFirebaseManager.sharedManager!
        let env = manager.environtment
        XCTAssertEqual(env, try! HMPFirebaseFilesProvider.defaultEnvirontment())
        XCTAssertFalse(manager.configured)
    }
    
    func testConstructor_True() {
        let env = HMPEnvironment(name: "Development", file: try! HMPFile(filename: "GoogleService-Info", ofType: "plist"))
        let manager = HMPFirebaseManager(environtment: env)
        XCTAssertEqual(env, manager.environtment)
        XCTAssertFalse(manager.configured)
    }
    
    func testConnect() {
        let env = HMPEnvironment(name: "Development", file: try! HMPFile(filename: "GoogleService-Info", ofType: "plist"))
        var manager = HMPFirebaseManager(environtment: env)
        manager.connect()
        XCTAssertTrue(manager.configured)
        
    }
}
