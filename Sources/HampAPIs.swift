//
//  HampAPI.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 12/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

internal protocol APIBase {
    associatedtype T : HampObject
}

/// User API
internal protocol APIUser: APIBase {
    static func get(by identifier: String,
                    onSuccess: ServerSuccess<T>,
                    onError: ServerError)
    
    static func create(object: HampDatabaseObject,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
    
    static func update(object: HampObject,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
    
    static func unsubscribe(identifier: String,
                            onSuccess: ServerSuccess<T>,
                            onError: ServerError)
    
    static func remove(object: HampDatabaseObject,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
    
}

/// Credit card API
internal protocol APICreditCard: APIBase {
    
    static func create(object: HampDatabaseObject,
                       parent: HampUser,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
   
    static func remove(object: HampDatabaseObject,
                       parent: HampUser,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
}

/// Booking API
internal protocol APIBooking: APIBase {
    static func booking(user: HampUser,
                        card: HampCreditCard,
                        order: HampOrder,
                        onSuccess: ServerSuccess<T>,
                        onError: ServerError)
}

