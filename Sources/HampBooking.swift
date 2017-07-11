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
    public var locker : HampLocker
    
    public func validate() throws {}
}
