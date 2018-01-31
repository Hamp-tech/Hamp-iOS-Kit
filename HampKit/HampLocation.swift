//
//  HampLocation.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampLocation: HampObject {
    
    public var latitude: Double
    public var longitude: Double
    public var name: String
    
    public init (latitude: Double, longitude: Double, name: String) throws {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        
        try validate()
    }
    
    public init (properties: Dictionary<String, Any>?) throws {
        try self.init(latitude: properties?[Constants.Location.latitude] as! Double,
              longitude: properties?[Constants.Location.longitude] as! Double,
              name: properties?[Constants.Location.name] as! String)
    }
    
    public func validate() throws {}

}
