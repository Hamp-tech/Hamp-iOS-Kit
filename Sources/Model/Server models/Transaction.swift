//
//  Transaction.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

class Transaction: Objectable {
    
    var identifier: String?
    var userID: String?
    var booking: Booking?
    var creditCardIdentifier: String?
    var pickUpDate: String?
    var deliveryDate: String?
    var created: String?

    init(identifier: String? = nil,
         userID: String? = nil,
         booking: Booking? = nil,
         creditCardIdentifier: String? = nil,
         pickUpDate: String? = nil,
         deliveryDate: String? = nil,
         created: String? = nil) {
        self.identifier = identifier
        self.userID = userID
        self.booking = booking
        self.creditCardIdentifier = creditCardIdentifier
        self.pickUpDate = pickUpDate
        self.deliveryDate = deliveryDate
        self.created = created
    }
    
    func validate() throws { }
}
