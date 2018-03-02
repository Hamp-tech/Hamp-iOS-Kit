//
//  Hamp.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

typealias onResponse<T: Codable> = (Response<T>) -> ()

final class Hamp {
    
    // MARK: - Properties
    private static var authRequester = AuthRequester()
    private static var userRequester = UserRequester()
    private static var transactionsRequester = TransactionsRequester()
    
}

extension Hamp {
    struct Auth {
        // Sign in
        static func signIn(email: String, password: String, onResponse: @escaping onResponse<User>) {
            authRequester.singIn(email: email, password: password) { (response) in
                setCurrentUser(response: response)
                onResponse(response)
            }
        }
        
        // Sign up
        
        static func signUp(user: User, onResponse: @escaping onResponse<User>) {
            authRequester.signUp(user: user) { response in
                setCurrentUser(response: response)
                onResponse(response)
            }
        }
        
        static var user: User? = {
            let ud = UserDefaults.standard
            let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: ud.string(forKey: Schemes.UserDefaults.currentUser)!.data(using: .utf8)!)
            
            return user
        }()
        
        static func logout() {
            let ud = UserDefaults.standard
            ud.removeObject(forKey: Schemes.UserDefaults.currentUser)
        }
        
        // Restore
        
        private static func setCurrentUser(response: Response<User>) {
            if let u = response.data {
                let ud = UserDefaults.standard
                ud.set(u.json, forKey: Schemes.UserDefaults.currentUser)
            }
        }
    }
}

extension Hamp {
    struct Users {
        // Update user
        static func update(user: User, onResponse: @escaping onResponse<User>) {
            userRequester.update(user: user, onResponse: onResponse)
        }
        
        // Create credit card
        static func createCard(userID: String, card: CreditCard, onResponse: @escaping onResponse<CreditCard>) {
            userRequester.createCreditCard(userIdentifier: userID, card: card, onResponse: onResponse)
        }
        
        // Remove credit card
        static func deleteCard(userID: String, cardID: String, onResponse: @escaping onResponse<String>) {
            userRequester.deleteCreditCard(userIdentifier: userID, cardIdentifier: cardID, onResponse: onResponse)
        }
    }
}

extension Hamp {
    struct Transactions {
        // Create transaction
        static func createTransaction(transaction: Transaction, onResponse: @escaping onResponse<Transaction>) {
            transactionsRequester.createTransaction(transaction: transaction, onResponse: onResponse)
        }
        
        // All transactions
        static func transactions(userID: String, onResponse: @escaping onResponse<[Transaction]>) {
            transactionsRequester.userTransactions(userID: userID, onResponse: onResponse)
        }
        
        // Deliver
        static func deliver(transactionID: String, userID: String, onResponse: @escaping onResponse<Transaction>) {
            transactionsRequester.deliver(transactionID: transactionID, userID: userID, onResponse: onResponse)
        }
        
        // Update phase
    }
}

extension Hamp {
    // Scripts
}