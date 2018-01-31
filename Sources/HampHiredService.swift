//
//  HampHiredService.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampHiredService: HampObject {
    
    public var service: HampService
    public var quantity: Int
    
    public init (service: HampService,
                 quantity: Int) throws {
        self.service = service
        self.quantity = quantity
        
        try validate()
    }
    
    public init (properties: Dictionary <String, Any>?) throws {
        try self.init(service: properties?[Constants.HiredService.service] as! HampService,
                  quantity: properties?[Constants.HiredService.quantity] as! Int)
    }
    
    public func validate() throws {}
}
