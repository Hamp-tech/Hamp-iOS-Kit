//
//  Schemes.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 17/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

struct Schemes {
    private static let baseURL = "http://localhost:8181/api/v1"
    
    struct Auth {
        static let signIn = baseURL + "/auth/signin"
        static let signUp = baseURL + "/auth/signup"
    }
    
    struct User {
        static let update = baseURL + "/users/{pid}"
        static let createCreditCard = baseURL + "/users/{pid}/cards"
        static let removeCreditCard = baseURL + "/users/{pid}/cards/{cid}"
    }
	
	struct Transaction {
		static let createTransaction = baseURL + "/users/{pid}/transactions"
		static let userTransactions = baseURL + "/users/{pid}/transactions"
		static let deliver = baseURL + "/users/{pid}/transactions/{tid}/deliver"
	}
    
    struct Security {
        static let gateway = "QfTjWnZr4u7x!A%D*G-JaNdRgUkXp2s5"
    }
    
    struct Regex {
        static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let visa = "^4[0-9]{12}(?:[0-9]{3})?$"
        static let cvv = "^([0-9]{3})$"
        static let phone = "^[9|6|7][0-9]{8}$"
    }
    
    struct UserDefaults {
        static let currentUser = "com.hamp.HampKit.UserDefaults.currentUser"
    }
}
