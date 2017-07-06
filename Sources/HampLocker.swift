//
//  HampLocker.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampLocker : HampFirebaseObject {
    
    //MARK: Static properties
    public static var tableName: String = Constants.FirebaseTableNames.lockers
    
    //MARK: Properties
    public var identifier: String
    public var booked : Bool
    public var lockerID : String
    public var secretKey : String
    
    //MARK: Constructors
    public init(identifier : String) {
        self.init(
            identifier: identifier,
            booked: false,
            lockerID: "",
            secretKey: "")
    }
    
    public init(identifier : String,
                booked : Bool = false,
                lockerID : String = "",
                secretKey : String = "") {
        self.identifier = identifier
        self.booked = booked
        self.lockerID = lockerID
        self.secretKey = secretKey
        
    }
    
    public init(identifier: String, properties: Dictionary<String, Any>?) {
        if let ps = properties {
            self.init(
                identifier: identifier,
                booked: ps[Constants.Locker.booked] as! Bool,
                lockerID: ps[Constants.Locker.lockerID] as! String,
                secretKey: ps[Constants.Locker.secretKey] as! String)
        } else {
            self.init(identifier: identifier)
        }
    }
}

