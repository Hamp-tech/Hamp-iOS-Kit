//
//  APIUser.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 12/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Alamofire

internal protocol APIUser : APIExtended {
    static func unsubscribe(identifier: String,
                            onSuccess: ServerSuccess<T>,
                            onError: ServerError)
}

public final class HampAPIUser : APIUser {
    typealias T = HampUser
    /// Properties
    private static let path = Constants.ServerPaths.user
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - onSuccess: <#onSuccess description#>
    ///   - onError: <#onError description#>
    static func get(by identifier: String,
                    onSuccess: ServerSuccess<T>,
                    onError: ServerError) {
        let userPath = "\(path)/\(identifier)"
        HampServerManager
            .shared!
            .request(HampUser.self,
                     path: userPath,
                     method: .get,
                     parameters: nil,
                     onSuccess: onSuccess,
                     onError: onError)
    }
    
    /// Request to create a new user on hamp server
    ///
    /// - Parameters:
    ///   - object: user to create
    ///   - onSuccess: called if created was successfully
    ///   - onError: called if an error occurred
    static func create(object: HampDatabaseObject,
                       parent: HampDatabaseObject? = nil, 
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        let properties = object.propertiesDictionary()
        HampServerManager
            .shared!
            .request(HampUser.self,
                     path: path,
                     method: HTTPMethod.post,
                     parameters: properties,
                     onSuccess: onSuccess,
                     onError: onError)

    }
    
    /// Update object on hamp server
    ///
    /// - Parameters:
    ///   - object: object to update
    ///   - onSuccess: called if updated was successfully
    ///   - onError: called if an error ocurred
    static func update(object: HampObject,
                       parent: HampDatabaseObject? = nil,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        let properties = object.propertiesDictionary()
        let userPath = path + "/\((object as! HampUser).identifier!)"
        
        
        HampServerManager
            .shared!
            .request(HampUser.self,
                     path: userPath,
                     method: .put,
                     parameters: properties,
                     onSuccess: onSuccess,
                     onError: onError)
    }
    
    /// Remove user
    ///
    /// - Parameters:
    ///   - object: user to remove
    ///   - parent: nil
    ///   - onSuccess: called if unsubscribe was succesfully
    ///   - onError: called if an error occurred
    static func remove(object: HampDatabaseObject,
                       parent: HampDatabaseObject? = nil,
                       onSuccess: ((HampHTTPResponse<HampUser>) -> ())?,
                       onError: ServerError) {
        assertionFailure("Needs to be implemented on server")
    }
    
    /// Unsubscribe an user
    ///
    /// - Parameters:
    ///   - object: user to unsubscribe
    ///   - onSuccess: called if unsubscribe was succesfully
    ///   - onError: called if an error occurred
    static func unsubscribe(identifier: String,
                            onSuccess: ServerSuccess<T>,
                            onError: ServerError) {
        let userPath = path + identifier
        HampServerManager
            .shared!
            .request(HampUser.self,
                     path: userPath,
                     method: .delete,
                     parameters: nil,
                     onSuccess: onSuccess,
                     onError: onError)
    }
}


