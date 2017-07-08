//
//  HampKitRegexTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitRegexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVisaRegex_valid() {
        var regex : HampRegex?
        XCTAssertNoThrow(regex = try HampRegex(pattern: Constants.Regex.visa) )
        XCTAssertTrue(regex!.parse(input: "4111111111111111"))
    }
    
    func testVisaRegex_noValidInput() {
        var regex : HampRegex?
        XCTAssertNoThrow(regex = try HampRegex(pattern: Constants.Regex.visa) )
        XCTAssertFalse(regex!.parse(input: "411111111111111")) //A less 1
    }
}
