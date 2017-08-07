//
//  HampBaseErrorTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampBaseErrorTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCastingToAuthError() {
        let error: HampBaseError = HampFirebaseAuth.AuthResponseError.userNotFound as HampBaseError
        XCTAssertEqual(error.description, HampFirebaseAuth.AuthResponseError.userNotFound.description)
    }
    
    func testCastingToServerError() {
        let error: HampBaseError = HampServerManager.ServerResponseError.notFound
        XCTAssertEqual(error.description, HampServerManager.ServerResponseError.notFound.description)
    }
    
    
}
