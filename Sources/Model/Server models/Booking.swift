//
//  Booking.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

class Booking: Objectable {
    
    enum PickUpTime: String, HampCodable {
        case morning = "0"
        case afternoon = "1"
    }
    
    var identifier: String?
    var userID: String?
    var basket: [HiredService]?
    var price: Float32?
    var point: String? // Identifier to location
    var pickUpTime: PickUpTime?
    var deliveryLockers: [Locker]?
    var pickUpLockers: [Locker]?
    var created: String?
    
    init(identifier: String? = nil,
         userID: String? = nil,
         basket: [HiredService]? = nil,
         price: Float32? = nil,
         point: String? = nil,
         pickUpTime: PickUpTime? = nil,
         deliveryLockers: [Locker]? = nil,
         pickUpLockers: [Locker]? = nil,
         created: String? = nil) {
        self.identifier = identifier
        self.userID = userID
        self.basket = basket
        self.price = price
        self.point = point
        self.pickUpTime = pickUpTime
        self.deliveryLockers = deliveryLockers
        self.pickUpLockers = pickUpLockers
        self.created = created
    }
    
    func validate() throws { }
}
