//
//  HampPoint.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampPoint: HampObject {
    
    public var location: HampLocation
    public var cp: UInt8
    public var adress: String
    public var city: String
    public var lockers: [HampLocker]
    
    public init (location: HampLocation,
                 cp: UInt8,
                 adress: String,
                 city: String,
                 lockers: [HampLocker]) throws {
        self.location = location
        self.cp = cp
        self.adress = adress
        self.city = city
        self.lockers = lockers
        
        try validate()
    }
    
    public init (properties: Dictionary<String,Any>?) throws {
        try self.init(location: properties?[Constants.HampPoint.location] as! HampLocation,
                  cp: properties?[Constants.HampPoint.cp] as! UInt8,
                  adress: properties?[Constants.HampPoint.adress] as! String,
                  city: properties?[Constants.HampPoint.city] as! String,
                  lockers: properties?[Constants.HampPoint.location] as! [HampLocker])
    }
    
    public func validate() throws {}
    
}
