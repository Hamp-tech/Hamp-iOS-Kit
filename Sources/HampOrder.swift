//
//  HampOrder.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampOrder : HampObject {
    
    public var identifier: String?
    public var userID: String
    public var basket: HampBasket
    public var price: String
    public var pickUpTime: String
    public var deliveryLocker: HampLocker
    public var pickUpLocker: HampLocker
    public var location: HampLocation

    public init (identifier: String,
                 userID: String,
                 basket: HampBasket,
                 price: String,
                 pickUpTime: String,
                 deliveryLocker: HampLocker,
                 pickUpLocker: HampLocker,
                 location: HampLocation) throws {
        self.identifier = identifier
        self.userID = userID
        self.basket = basket
        self.price = price
        self.pickUpTime = pickUpTime
        self.deliveryLocker = deliveryLocker
        self.pickUpLocker = pickUpLocker
        self.location = location
        
        try validate()
    }
    
    public func validate() throws {}
    
    
}
