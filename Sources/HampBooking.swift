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

    //MARK: Constructors
    public init(transaction: HampTransaction?,
         deliveryLocker: HampLocker?,
         collectionLocker: HampLocker?) {
        self.transaction = transaction
        self.deliveryLocker = deliveryLocker
        self.collectionLocker = collectionLocker
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
