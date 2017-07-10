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
        static let creditCards = "credit_cards"
        static let transactions = "transactions"
    }
    
    /// Keys for locker properties names
    public struct Locker {
        static let booked = "booked"
        static let lockerID = "lockerID"
        static let secretKey = "secretKey"
    }
    
    /// Credit card properties names
    public struct CreditCard {
        static let number = "number"
        static let month = "month"
        static let year = "year"
        static let cvv = "cvv"
    }
    
    
    public struct Transaction {
        static let userID = "userID"
        static let cardID = "cardID"
        static let order = "order"
    }
    
    /// Regex
    public struct Regex {
        static let visa = "^4[0-9]{12}(?:[0-9]{3})?$"
        static let cvv = "^([0-9]{3})$"
    }
    
    
}
