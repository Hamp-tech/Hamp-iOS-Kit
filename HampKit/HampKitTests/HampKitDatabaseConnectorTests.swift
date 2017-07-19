//
//  HampKitDatabaseConnectorTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 7/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitDatabaseConnectorTests: XCTestCase {
    
    var connector : HampFirebaseDatabaseConnector<HampLocker>!
    override func setUp() {
        super.setUp()
        
        connector =  HampFirebaseDatabaseConnector<HampLocker>()
        
    }
    
    func testConstructor_defaultProperties() {
        XCTAssertEqual(connector.path, HampLocker.tableName)
        XCTAssertNil(connector.delegate)
        XCTAssertFalse(connector.observing)
    }
    
    func testCreateChild_defaultProperties() {
        let con = connector.child(childID: "123")
        XCTAssertEqual(con.path, HampLocker.tableName + "/123")
        XCTAssertNil(con.delegate)
        XCTAssertFalse(con.observing)
    }
    
    func testObserveEventsSingleAddition_observingTrue() {
        connector.observe(of: .added)
        XCTAssertTrue(connector.observing)
    }
    
    func testObserveEventsSingleAdition_observingTrueAndAfterFalse() {
        connector.observe(of: .added)
        XCTAssertTrue(connector.observing)
        connector.remove(of: .added)
        XCTAssertFalse(connector.observing)
    }
    
    func testObserveEventsArrayAdition_observingTrue() {
        connector.observe(of: [.added, .changed])
        XCTAssertTrue(connector.observing)
    }
    
    func testObserveEventsArrayAdition_observingTrueAndAfterFalse() {
        connector.observe(of: [.added, .changed])
        XCTAssertTrue(connector.observing)
        connector.remove(of: .added)
        connector.remove(of: .changed)
        XCTAssertFalse(connector.observing)
    }
    
    func testObserveEventSingleAddition_removeObserverTypeTwice() {
        //Check to avoid exceptions removing same observer type
        connector.observe(of: .added)
        connector.remove(of: .added)
        connector.remove(of: .added)
        XCTAssertFalse(connector.observing)
        
    }
    
}
