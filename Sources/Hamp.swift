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
    
}

extension Hamp {
    struct Auth {
        // Sign in
        static func signIn(email: String, password: String, onResponse: @escaping onResponse<User>) {
            authRequester.singIn(email: email, password: password, onResponse: onResponse)
        }
        
        // Sign up
        
        static func signUp(user: User, onResponse: @escaping onResponse<User>) {
            authRequester.signUp(user: user, onResponse: onResponse)
        }
        
        // Restore
    }
}

extension Hamp {
    
    struct Users {
        // Update user
        static func update(user: User, onResponse: @escaping onResponse<User>) {
            
        }
    }
}

extension Hamp {
    // Create credit card
    
    // Remove credit card
}

extension Hamp {
    // Create transaction
    
    // All transactions
    
    // Deliver
    
    // Update phase
}

extension Hamp {
    // Scripts
}
