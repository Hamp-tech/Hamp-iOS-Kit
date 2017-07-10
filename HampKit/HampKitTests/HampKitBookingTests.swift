//
//  HampKitBookingTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest

class HampKitBookingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBookingConstructor() {
        let transaction = try! HampTransaction(identifier: nil, userID: "123", cardID: "123", order: HampOrder(smallBag: 1))
        let locker = try! HampLocker(identifier: "123", booked: false, lockerID: "123", secretKey: "1234")
        let booking = HampBooking(transaction: transaction, locker: locker)
        XCTAssertEqual(booking.transaction.identifier, transaction.identifier)
        XCTAssertEqual(booking.locker.identifier, locker.identifier)
        
    }
    
}
