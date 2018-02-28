//
//  Locker.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

class Locker: Objectable {

    var identifier: String?
    var number: Int?
    var code: String?
    var available: Bool?
    var capacity: Size?
        
    init(identifier: String? = nil, number: Int? = nil, code: String? = nil, available: Bool? = nil, capacity: Size? = nil) {
        self.identifier = identifier
        self.number = number
        self.code = code
        self.available = available
        self.capacity = capacity
    }
    
    func validate() throws { }
}
