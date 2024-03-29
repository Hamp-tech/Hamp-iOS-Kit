//
//  HampCreditCard.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampCreditCard : HampDatabaseObject {
    
    //MARK: Class properties
    public static var tableName: String = Constants.FirebaseTableNames.creditCards
    
    //MARK: Properties
    public var identifier: String?
    public var number : String!
    public var month : String!
    public var year : String!
    public var cvv : String!
    
    //MARK: Constructors
    public init(identifier : String? = nil,
                number : String?,
                month : String?,
                year : String?,
                cvv : String?) throws {
        self.identifier = identifier
        self.number = number
        self.month = month
        self.year = year
        self.cvv = cvv
        
        try validate()
    }
    
    public init(identifier: String? = nil, properties: Dictionary<String, Any>?) throws {
        try self.init(
            identifier: identifier,
            number: properties?[Constants.CreditCard.number] as? String,
            month: properties?[Constants.CreditCard.month] as? String,
            year: properties?[Constants.CreditCard.year] as? String,
            cvv: properties?[Constants.CreditCard.cvv] as? String)
    }
    
    //MARK: HampObject protocol
    public func validate() throws {
        guard
            let n = number,
            let m = month,
            let y = year,
            let c = cvv else {
                throw HampFirebaseObjectError.missingProperties
                
        }
        
        guard (try! HampRegex(pattern: Constants.Regex.visa)).parse(input: String(n)) else {
            throw CreditCardError.invalidNumber
        }
        
        guard let mInt = Int(m), mInt > 0 && mInt < 13 else {
            throw CreditCardError.invalidMonth
        }
        
        guard let yInt = Int(y), 2000+yInt >= Date.currentYear() else {
            throw CreditCardError.invalidYear
        }
        
        if 2000+yInt == Date.currentYear() && mInt < Date.currentMonth() {
            throw CreditCardError.invalidMonth
        }
        
        guard (try! HampRegex(pattern: Constants.Regex.cvv)).parse(input: String(c)) else {
            throw CreditCardError.invalidCVV
        }
    }
}

extension HampCreditCard {
    enum CreditCardError : Swift.Error, CustomStringConvertible {
        case invalidNumber
        case invalidMonth
        case invalidYear
        case invalidCVV
        
        var description: String {
            switch self {
            case .invalidNumber:
                return "invalid number"
            case .invalidMonth:
                return "invalid month"
            case .invalidYear:
                return "invalid year"
            case .invalidCVV:
                return "invalid cvv"
            }
        }
    }
}
