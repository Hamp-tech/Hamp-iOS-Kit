//
//  HMPLocker.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HMPLocker : HMPFirebaseObject {
    public var identifier: String
    public var booked : Bool
    public var lockerID : String
    public var secretKey : String
    
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
}
