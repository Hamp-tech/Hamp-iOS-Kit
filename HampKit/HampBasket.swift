//
//  HampBasket.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampBasket: HampObject {
    
    public var hiredServices: [HampService]
    
    public init (hiredServices: [HampService]) throws {
        self.hiredServices = hiredServices
        try validate()
    }
    
    public init (properties: Dictionary<String, Any>?) throws {
        try self.init(hiredServices: properties?[Constants.Basket.hiredServices] as! [HampService])
    }
    
    public func validate() throws {}
}
