//
//  HampConstants.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

internal struct Constants {
    
    ///API URLs
    internal static let productionAPIURL = "Http://www.usehamp.io/api/v1"
    internal static let developmentAPIURL = "https://hampapi.herokuapp.com/api/v1"
    
    ///Firebase files names
    internal static let productionFirebaseFileName = "GoogleService-Info"
    internal static let developmentFirebaseFileName = "GoogleServie-Dev-Info"

    internal struct UserDefaultsKeys {
        private static let base = "com.Hamp.Hamp.UserDefaults."
        static let currentUser = base + "currentUser"
    }
    
    /// Firebase table names
    internal struct FirebaseTableNames {
        static let lockers = "lockers"
        static let creditCards = "credit_cards"
        static let transactions = "transactions"
        static let users = "users"
    }
    
    internal struct ServerPaths {
        static let user = "/users"
        static let creditCards = user + "/%@/cards"
        static let booking = user + "/%@/booking"
    }
    
    /// Keys for locker properties names
    internal struct Locker {
        static let booked = "booked"
        static let lockerID = "lockerID"
        static let secretKey = "secretKey"
    }
    
    /// Credit card properties names
    internal struct CreditCard {
        static let number = "number"
        static let name = "name"
        static let month = "month"
        static let year = "year"
        static let cvv = "cvv"
    }
    
    
    /// Transaction properties names
    internal struct Transaction {
        static let userID = "userID"
        static let cardID = "cardID"
        static let order = "order"
        static let date = "date"
        static let payment = "payment"
    }
    
    /// User properties names
    internal struct User {
        static let name = "name"
        static let surname = "surname"
        static let mail = "mail"
        static let phone = "phone"
        static let birthday = "birthday"
        static let gender = "gender"
        static let tokenFCM = "tokenFCM"
        static let language = "language"
        static let OS = "OS"
        static let signupDate = "signupDate"
    }
    
    /// Regex
    internal struct Regex {
        static let visa = "^4[0-9]{12}(?:[0-9]{3})?$"
        static let cvv = "^([0-9]{3})$"
    }
    
    
}
