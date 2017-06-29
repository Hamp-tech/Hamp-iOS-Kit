//
//  HampKitTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor_True() {
        let file = try? HMPFile(filename: "Info", ofType: "plist")
        XCTAssertEqual("Info.plist", file!.filename)
    }
        
}
