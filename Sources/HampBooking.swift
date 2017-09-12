//
//  Booking.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampBooking : HampObject {
    
    //MARK: Properties
    public var transaction : HampTransaction?
    public var deliveryLocker : HampLocker?
    public var collectionLocker : HampLocker?
    public var date: String?
    public var payment: Int?

    //MARK: Constructors
    public init(transaction: HampTransaction?,
         deliveryLocker: HampLocker?,
         collectionLocker: HampLocker?,
         date: String?,
         payment: Int?) {
        self.transaction = transaction
        self.deliveryLocker = deliveryLocker
        self.collectionLocker = collectionLocker
        self.date = date
        self.payment = payment
        
    }
    
    
    /// Validate
    ///
    /// - Throws: throw if transaction or locker is not valid
    public func validate() throws {
        try transaction?.validate()
        try deliveryLocker?.validate()
        try collectionLocker?.validate()
    }
}
