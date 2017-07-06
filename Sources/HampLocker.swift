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
    public var identifier: String
    public var booked : Bool!
    public var lockerID : String!
    public var secretKey : String!
    
    //MARK: Constructors
    public init(identifier : String,
                booked : Bool?,
                lockerID : String?,
                secretKey : String?) throws {
        self.identifier = identifier
        self.booked = booked
        self.lockerID = lockerID
        self.secretKey = secretKey
        
        try checkParameterProperties()
    }
    
    public init(identifier: String, properties: Dictionary<String, Any>?) throws {
        try self.init(
            identifier: identifier,
            booked: properties?[Constants.Locker.booked] as? Bool,
            lockerID: properties?[Constants.Locker.lockerID] as? String,
            secretKey: properties?[Constants.Locker.secretKey] as? String)
    }
    
    public func checkParameterProperties() throws {
        guard
            identifier.count > 0,
            let _ = booked,
            let l = lockerID,
            let s = secretKey,
            l.count > 0,
            s.count > 0 else {
                throw HampFirebaseObjectError.missingProperties
        }
        
    }
}


