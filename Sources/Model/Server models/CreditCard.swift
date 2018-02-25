//
//  CreditCard.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

struct CreditCard: Objectable {
    var identifier: String?
    var number: String?
    var expMonth: UInt8?
    var expYear: UInt8?
    var cvc: String?
    
    func validate() throws {
        
    }
}

extension CreditCard {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case number
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case cvc
    }
}
