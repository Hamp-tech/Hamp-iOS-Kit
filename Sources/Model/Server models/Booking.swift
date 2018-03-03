//
//  Booking.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class Booking: Objectable {
    
    public enum PickUpTime: String, HampCodable {
        case morning = "0"
        case afternoon = "1"
    }
    
    public var identifier: String?
    public var userID: String?
    public var basket: [HiredService]?
    public var price: Float32?
    public var point: String? // Identifier to location
    public var pickUpTime: PickUpTime?
    public var deliveryLockers: [Locker]?
    public var pickUpLockers: [Locker]?
    
    private var validator = Validator ()
    
    public init(identifier: String? = nil,
         userID: String? = nil,
         basket: [HiredService]? = nil,
         price: Float32? = nil,
         point: String? = nil,
         pickUpTime: PickUpTime? = nil,
         deliveryLockers: [Locker]? = nil,
         pickUpLockers: [Locker]? = nil) {
        self.identifier = identifier
        self.userID = userID
        self.basket = basket
        self.price = price
        self.point = point
        self.pickUpTime = pickUpTime
        self.deliveryLockers = deliveryLockers
        self.pickUpLockers = pickUpLockers
        
        addValidations()
    }
    
    private func addValidations () {
        let missingBasketValidation = Validation.init(validable: {
            return self.basket != nil && !self.basket!.isEmpty
        }) { (validated) in
            if !validated {throw BookingError.missingParameter("basket")}
        }
        
        let priceValidation = Validation.init(validable: {
            return self.price != nil && self.price! > 0
        }) { (validated) in
            if !validated {throw BookingError.missingParameter("price")}
        }
        
        let pointValidation = Validation.init(validable: { () -> Bool in
            return self.point != nil
        }) { (validated) in
            if !validated {throw BookingError.missingParameter("1")}
        }
        
        let pickUpTimeValidation = Validation.init(validable: { () -> Bool in
            return self.pickUpTime != nil
        }) { (validated) in
            if !validated {throw BookingError.missingParameter("pickUpTime")}
        }
        
        let deliveryLockersValidation = Validation.init(validable: { () -> Bool in
            return self.deliveryLockers != nil && !self.deliveryLockers!.isEmpty
        }) { (validated) in
            if !validated { throw BookingError.missingParameter("deliveryLockers") }
        }
        
        let pickUpLockersValidation = Validation.init(validable: { () -> Bool in
            return self.pickUpLockers != nil && !self.pickUpLockers!.isEmpty
        }) { (validated) in
            if !validated { throw BookingError.missingParameter("pickUpLockers") }
        }
        
        validator.add(missingBasketValidation)
        validator.add(priceValidation)
        validator.add(pointValidation)
        validator.add(pickUpTimeValidation)
        validator.add(deliveryLockersValidation)
        validator.add(pickUpLockersValidation)
    }
    
    public func validate() throws {
        try validator.validate()
    }
}

extension Booking {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case userID
        case basket
        case price
        case point
        case pickUpTime
        case deliveryLockers
        case pickUpLockers
    }
}
