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
    public var transaction : HampTransaction
    public var delivery_locker : HampLocker
    public var collection_locker : HampLocker
    
    /// Validate
    ///
    /// - Throws: throw if transaction or locker is not valid
    public func validate() throws {
        try transaction.validate()
        try delivery_locker.validate()
        try collection_locker.validate()
    }
}
