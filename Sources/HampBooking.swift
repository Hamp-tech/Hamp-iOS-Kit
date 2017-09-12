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
    public var delivery_locker : HampLocker?
    public var collection_locker : HampLocker?

    //MARK: Constructors
    init(transaction: HampTransaction?,
         delivery_locker: HampLocker?,
         collectionLocker: HampLocker?) {
        self.transaction = transaction
        self.delivery_locker = delivery_locker
        self.collection_locker = collectionLocker
    }
    
    
    /// Validate
    ///
    /// - Throws: throw if transaction or locker is not valid
    public func validate() throws {
        try transaction?.validate()
        try delivery_locker?.validate()
        try collection_locker?.validate()
    }
}
