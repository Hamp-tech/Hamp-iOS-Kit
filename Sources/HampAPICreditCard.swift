//
//  HampAPICreditCard.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 13/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation


internal final class HampAPICreditCard: APICreditCard {
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
                       parent: HampUser,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        
        guard let id = parent.identifier else {
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
    
    /// Remove the user credit card
    ///
    /// - Parameters:
    ///   - object: credit card to removed
    ///   - parent: credit card owner user
    ///   - onSuccess: called if remove was successfully
    ///   - onError: called if an error occurred
    static func remove(object: HampDatabaseObject,
                       parent: HampUser,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {

        guard let id = parent.identifier else {
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
