//
//  HampKitTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitFileTests: XCTestCase {
    
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
        XCTAssertEqual(file?.filepath, mainBundlePath())
        XCTAssertEqual(file!.route, mainBundlePath() + "/Info.plist")
    }
    
    func testThrow_True_FileMissing() {
        XCTAssertThrowsError(try HMPFile(filename: "info", ofType: "plist")) { error in
            XCTAssertEqual(error as? HMPFile.FileError, HMPFile.FileError.missingFileError)
        }
    }
    
    func testThrow_False_FileMissing() {
        XCTAssertNoThrow(try HMPFile(filename: "Info", ofType: "plist"))
    }
        
}

extension HampKitFileTests {
    fileprivate func mainBundlePath() -> String {
       return Bundle.main.bundlePath
    }
}
