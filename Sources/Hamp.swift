//
//  Hamp.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public typealias onResponse<T: Codable> = (Response<T>) -> ()

public final class Hamp {
    
    // MARK: - Properties
    private static var authRequester = AuthRequester()
    private static var userRequester = UserRequester()
    private static var transactionsRequester = TransactionsRequester()
    
}

extension Hamp {
    public struct Auth {
        // Sign in
        public static func signIn(email: String, password: String, onResponse: @escaping onResponse<User>) {
			authRequester.singIn(email: email, password: password, onResponse: onResponse)
        }
        
        // Sign up
        
        public static func signUp(user: User, onResponse: @escaping onResponse<User>) {
            authRequester.signUp(user: user, onResponse: onResponse)
        }
        
        public static var user: User? {
            get {
                return LogedUserHandler.retrieve()
            }
        }
        
        public static func logout() {
            let ud = UserDefaults.standard
            ud.removeObject(forKey: Schemes.UserDefaults.currentUser)
        }
        
        // Restore
		
    }
}

extension Hamp {
    public struct Users {
        // Update user
        public static func update(user: User, onResponse: @escaping onResponse<User>) {
			userRequester.update(user: user, onResponse: onResponse)
        }
        
        // Create credit card
        public static func createCard(userID: String, card: CreditCard, onResponse: @escaping onResponse<CreditCard>) {
			userRequester.createCreditCard(userIdentifier: userID, card: card, onResponse: onResponse)
        }
        
        // Remove credit card
        public static func deleteCard(userID: String, cardID: String, onResponse: @escaping onResponse<String>) {
            userRequester.deleteCreditCard(userIdentifier: userID, cardIdentifier: cardID, onResponse: onResponse)
        }
    }
}

extension Hamp {
    public struct Transactions {
        // Create transaction
        public static func createTransaction(transaction: Transaction, onResponse: @escaping onResponse<Transaction>) {
            transactionsRequester.createTransaction(transaction: transaction, onResponse: onResponse)
        }
		
		public static func transaction(transactionID: String, onResponse: @escaping onResponse<Transaction>) {
			transactionsRequester.transaction(userID: "", transactionID: transactionID, onResponse: onResponse)
		}
        
        // All transactions
        public static func transactions(userID: String, onResponse: @escaping onResponse<[Transaction]>) {
            transactionsRequester.userTransactions(userID: userID, onResponse: onResponse)
        }
        
        // Deliver
        public static func deliver(transactionID: String, userID: String, onResponse: @escaping onResponse<Transaction>) {
            transactionsRequester.deliver(transactionID: transactionID, userID: userID, onResponse: onResponse)
        }
        
        // Update phase
    }
}

extension Hamp {
    // Scripts
}
