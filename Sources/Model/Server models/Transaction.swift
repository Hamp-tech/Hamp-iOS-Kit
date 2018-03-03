//
//  Transaction.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class Transaction: Objectable {
    
    public var identifier: String?
    public var userID: String?
    public var booking: Booking?
    public var creditCardIdentifier: String?
    public var pickUpDate: String?
    public var deliveryDate: String?
    public var created: String?
    
    public init(identifier: String? = nil,
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
    
    public func validate() throws { }
}
