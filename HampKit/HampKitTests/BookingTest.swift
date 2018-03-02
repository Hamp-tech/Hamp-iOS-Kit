//
//  BookingTest.swift
//  HampKitTests
//
//  Created by Aleix Baggerman on 02/03/2018.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class BookingTest: XCTestCase {
    
    func testSuccedBooking () {
        let basket  = [HiredService.init(), HiredService.init()]
        let pickUpTime = Booking.PickUpTime.afternoon
        let deliveryLockers = [Locker.init()]
        let pickUpLockers = [Locker.init()]
        
        let booking = Booking.init(basket: basket, price: 30, point: "Point", pickUpTime: pickUpTime, deliveryLockers: deliveryLockers, pickUpLockers: pickUpLockers);
        do {
            try booking.validate()
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testMissingBasket () {
        let booking = Booking.init();
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("basket").description)
        }
    }
    
    func testMissingPrice () {
        let basket  = [HiredService.init(), HiredService.init()]
        let booking = Booking.init(basket: basket);
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("price").description)
        }
    }
    
    
    func testMissingPickUpTime () {
        let basket  = [HiredService.init(), HiredService.init()]
        let booking = Booking.init(basket: basket, price: 30, point: "Point");
        
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("pickUpTime").description)
        }
    }
    
    func testMissingDeliveryLockers () {
        let basket  = [HiredService.init(), HiredService.init()]
        let pickUpTime = Booking.PickUpTime.afternoon
        let booking = Booking.init(basket: basket, price: 30, point: "Point", pickUpTime: pickUpTime);
        
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("deliveryLockers").description)
        }
    }
    
    func testMissingPickUpLockers () {
        let basket  = [HiredService.init(), HiredService.init()]
        let pickUpTime = Booking.PickUpTime.afternoon
        let deliveryLockers = [Locker.init()]
        let booking = Booking.init(basket: basket, price: 30, point: "Point", pickUpTime: pickUpTime, deliveryLockers: deliveryLockers);
        
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("pickUpLockers").description)
        }
    }
    
    func testMissingPoint () {
        let basket  = [HiredService.init(), HiredService.init()]
        let booking = Booking.init(basket: basket, price: 30);
        
        XCTAssertThrowsError(try booking.validate()) { (error) in
            XCTAssertEqual((error as! BookingError).description, BookingError.missingParameter("1").description)
        }
    }
}
