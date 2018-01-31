//
//  HampHistory.swift
//  HampKit
//
//  Created by Aleix Baggerman on 19/12/2017.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampHistory: HampObject {
    
    public var transactions: [HampTransaction]
    
    public init (transactions: [HampTransaction]) throws {
        self.transactions = transactions
        
        try validate()
    }
    
    public func validate() throws {}
}
