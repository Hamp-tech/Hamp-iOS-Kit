//
//  HiredService.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class HiredService: HampCodable {
    public var service: String!
    public var amount: Int!
    
    public init (service: String, amount: Int) {
        self.service = service
        self.amount = amount
    }
}
