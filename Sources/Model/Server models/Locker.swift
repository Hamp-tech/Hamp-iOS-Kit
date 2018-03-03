//
//  Locker.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class Locker: Objectable {

    public var identifier: String?
    public var number: Int?
    public var code: String?
    public var available: Bool?
    public var capacity: Size?
        
    public init(identifier: String? = nil, number: Int? = nil, code: String? = nil, available: Bool? = nil, capacity: Size? = nil) {
        self.identifier = identifier
        self.number = number
        self.code = code
        self.available = available
        self.capacity = capacity
    }
    
    public func validate() throws { }
}
