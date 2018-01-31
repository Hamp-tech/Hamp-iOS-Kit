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
    internal static let productionAPIURL = "192.168.1.119:8181/api/v1"
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
        static let service = "service"
    }
    
    internal struct ServerPaths {
        static let user = "/users"
        static let creditCards = user + "/%@/cards"
        static let booking = user + "/%@/booking"
    }
    
    /// Keys for locker properties names
    internal struct Locker {
        static let number = "number"
        static let key = "key"
        static let available = "available"
        static let capacity = "capacity"
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
        static let password = "password"
        static let phone = "phone"
        static let birthday = "birthday"
        static let gender = "gender"
        static let signupDate = "signupDate"
        static let tokenFCM = "tokenFCM"
        static let os = "os"
        static let language = "language"
        static let lastActivity = "lastActivity"
        static let unsubscribed = "unsubscribed"
        static let stripeID = "stripeID"
    }
    
    /// Location properties names
    internal struct Location {
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let name = "name"
    }
    
    /// HampPoint properties names
    internal struct HampPoint {
        static let location = "location"
        static let cp = "cp"
        static let adress = "adress"
        static let city = "city"
        static let lockers = "lockers"
    }
    
    /// Service properties names
    internal struct Service {
        static let identifier = "identifer"
        static let active = "active"
        static let name = "name"
        static let description = "description"
        static let imageURL = "imageURL"
        static let price = "price"
        static let size = "size"
    }
    
    /// HiredServies properties names
    
    internal struct HiredService {
        static let service = "service"
        static let quantity = "quantity"
    }
    
    /// Basket properties names
    
    internal struct Basket {
        static let hiredServices = "hiredServices"
    }
    
    /// Order properties names
    
    internal struct Order {
        static let userID = "userID"
        static let basket = "basket"
        static let price = "price"
        static let pickUpTime = "pickUpTime"
        static let deliveryLocker = "deliveryLocker"
        static let pickUpLocker = "pickUpLocker"
        static let location = "location"
    }
    
    /// Regex
    internal struct Regex {
        static let visa = "^4[0-9]{12}(?:[0-9]{3})?$"
        static let cvv = "^([0-9]{3})$"
    }
    
    
    
}
