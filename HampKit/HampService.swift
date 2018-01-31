//
//  HampService.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampService: HampDatabaseObject {
    
    public static var tableName: String = Constants.FirebaseTableNames.service
    
    public var identifier: String?
    public var active: Bool
    public var name: String
    public var description: String
    public var imageURL: URL
    public var price: Double
    public var size: String
    
    public init (identifier: String?,
                 active: Bool,
                 name: String,
                 description: String,
                 imageURL: URL,
                 price: Double,
                 size: String) throws{
        self.identifier = identifier
        self.active = active
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.price = price
        self.size = size
        
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
        try self.init(identifier: identifier,
                  active: properties?[Constants.Service.active] as! Bool,
                  name: properties?[Constants.Service.name] as! String,
                  description: properties?[Constants.Service.description] as! String,
                  imageURL: properties?[Constants.Service.imageURL] as! URL,
                  price: properties?[Constants.Service.price] as! Double,
                  size: properties?[Constants.Service.size] as! String)
    }
    
    public func validate() throws {}
}

extension HampService {
    enum CodingKeys: String, CodingKey {
        case identifier = "firebaseID"
        case active
        case name
        case description
        case imageURL
        case price
        case size
    }
}

