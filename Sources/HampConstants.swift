//
//  HampConstants.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

internal struct Constants {
    
    /// Firebase table names
    public struct FirebaseTableNames {
        static let lockers = "lockers"
    }
    
    /// Keys for locker model
    public struct Locker {
        static let booked = "booked"
        static let lockerID = "lockerID"
        static let secretKey = "secretKey"
    }
    
    public struct Regex {
        static let visa = "^4[0-9]{12}(?:[0-9]{3})?$"
        static let cvv = "^([0-9]{3})$"
    }
    
    
}
