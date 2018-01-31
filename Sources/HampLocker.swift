//
//  HampLocker.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampLocker : HampDatabaseObject {
    
    //MARK: Static properties
    public static var tableName: String = Constants.FirebaseTableNames.lockers
    
    //MARK: Properties
    public var identifier: String?
    public var number: Int8?
    public var key: Int8?
    public var available: Bool?
    public var capacity: String?

    //MARK: Constructors
    
    public init (identifier: String?,
                 number: Int8?,
                 key: Int8?,
                 available: Bool?,
                 capacity: String?) throws {
        self.identifier = identifier
        self.number = number
        self.key = key
        self.available = available
        self.capacity = capacity
        
        try validate()
    }
    
    public init(identifier: String? = nil, properties: Dictionary<String, Any>?) throws {
        try self.init(identifier: identifier,
                      number: properties?[Constants.Locker.number] as? Int8,
                      key: properties?[Constants.Locker.key] as? Int8,
                      available: properties?[Constants.Locker.available] as? Bool,
                      capacity: properties?[Constants.Locker.capacity] as? String)
    }
    
    //MARK: HampObject protocol
    public func validate() throws {
        guard
            let _ = available,
            let n = number,
            let k = key,
            let _ = capacity,
            n > 0,
            k > 0 else {
                throw HampFirebaseObjectError.missingProperties
        }
        
    }
}



