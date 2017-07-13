//
//  HampAPI.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 12/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

internal protocol API {
    associatedtype T : HampObject
    
    static func create(object: HampDatabaseObject,
                       parent: HampDatabaseObject?,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
    
    static func remove(object: HampDatabaseObject,
                       parent: HampDatabaseObject?,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)
    
    static func update(object: HampObject,
                       parent: HampDatabaseObject?,
                       onSuccess: ServerSuccess<T>,
                       onError: ServerError)

}
