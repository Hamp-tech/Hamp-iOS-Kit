//
//  HampAPICreditCard.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 13/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation


internal final class HampAPICreditCard : APIExtended {
    typealias T = HampCreditCard
    
    ///Properties
    private static let path = Constants.ServerPaths.creditCards
    
    /// Create a new credit card on server
    ///
    /// - Parameters:
    ///   - object: Credit card to create
    ///   - onSuccess: called if create was successfully
    ///   - onError: called if an error ocurred
    static func create(object: HampDatabaseObject,
                       parent: HampDatabaseObject? = nil,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        guard let p = parent else {
            preconditionFailure("Pass user to update the credit card as parent")
        }
        
        guard p is HampUser else {
            preconditionFailure("Parent needs to be user")
        }
        
        guard let id = p.identifier else {
            preconditionFailure("User hasn't identifier")
        }
        
        let properties = object.propertiesDictionary()
        let creditCardPath = String(format: path, id)
        
        HampServerManager
            .shared!
            .request(HampCreditCard.self,
                     path: creditCardPath,
                     method: .post,
                     parameters: properties,
                     onSuccess:onSuccess,
                     onError: onError)
        
    }
    
    static func update(object: HampObject,
                       parent: HampDatabaseObject? = nil,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        assertionFailure("Not available update credit cards")
    }
    
    /// Remove the user credit card
    ///
    /// - Parameters:
    ///   - object: credit card to removed
    ///   - parent: credit card owner user
    ///   - onSuccess: called if remove was successfully
    ///   - onError: called if an error occurred
    static func remove(object: HampDatabaseObject,
                       parent: HampDatabaseObject? = nil,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        guard let p = parent else {
            preconditionFailure("Pass user to update the credit card as parent")
        }
        guard p is HampUser else {
            preconditionFailure("Parent needs to be user")
        }
        
        guard let id = p.identifier else {
            preconditionFailure("User hasn't identifier")
        }
        
        guard let cid = object.identifier else {
            preconditionFailure("Cards needs an identifier to be removed")
        }
        
        let creditCardPath = String(format: path+"/%@", id, cid)
        
        HampServerManager
            .shared!
            .request(HampCreditCard.self,
                     path: creditCardPath,
                     method: .delete,
                     parameters: nil,
                     onSuccess: onSuccess,
                     onError: onError)
    }
    
    
}
