//
//  APIUser.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 12/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Alamofire

internal protocol APIUser : API {
    static func unsubscribe(identifier: String,
                            onSuccess: ServerSuccess<T>,
                            onError: ServerError)
}

public final class HampAPIUser : APIUser {
    typealias T = HampUser
    /// Properties
    fileprivate static let path = "/users/"
    
    /// Request to create a new user on hamp server
    ///
    /// - Parameters:
    ///   - object: user to create
    ///   - onSuccess: called if created was successfully
    ///   - onError: called if an error occurred
    static func create(object: HampDatabaseObject,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        let properties = object.propertiesDictionary()
        HampServerManager
            .sharedManager
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
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError) {
        let properties = object.propertiesDictionary()
        let userPath = path + (object as! HampUser).identifier!
        
        HampServerManager
            .sharedManager
            .request(HampUser.self,
                     path: userPath,
                     method: .put,
                     parameters: properties,
                     onSuccess: onSuccess,
                     onError: onError)
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
            .sharedManager
            .request(HampUser.self,
                     path: userPath,
                     method: .delete,
                     parameters: nil,
                     onSuccess: onSuccess,
                     onError: onError)
    }
}


