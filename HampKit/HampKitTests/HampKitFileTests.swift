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
    }
    
    override func tearDown() {
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
    
    func testEquatable_True_SameFiles() {
        let f1 = try? HMPFile(filename: "Info", ofType: "plist")
        let f2 = try? HMPFile(filename: "Info", ofType: "plist")
        XCTAssertTrue(f1 == f2)
    }
    
    func testEquatable_False_DifferentFiles() {
        let f1 = try? HMPFile(filename: "Info", ofType: "plist")
        let f2 = try? HMPFile(filename: "info", ofType: "plist")
        XCTAssertFalse(f1 == f2)
    }
        
}

extension HampKitFileTests {
    fileprivate func mainBundlePath() -> String {
       return Bundle.main.bundlePath
    }
}
