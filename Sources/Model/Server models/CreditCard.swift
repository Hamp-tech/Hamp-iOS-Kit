//
//  CreditCard.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public struct CreditCard: Objectable {
    private let creditCardNumbers = 16 + 3
    
    public var identifier: String?
    public var name: String?
    public var number: String?
    public var expMonth: UInt8?
    public var expYear: UInt8?
    public var cvc: String?
    
    private var validator = Validator ()
    
    public init(identifier: String? = nil,
         name: String? = nil,
         number: String? = nil,
         expMonth: UInt8? = nil,
         expYear: UInt8? = nil,
         cvc: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.number = number?.replacingOccurrences(of: " ", with: "")
        self.expMonth = expMonth
        self.expYear = expYear
        self.cvc = cvc

        addValidations()
    }
    
    public init () {
        addValidations()
    }
    
    public func validate() throws {
        try validator.validate()
    }
    
    private func addValidations () {
        
        let missingNumberValidation = Validation.init(validable: {
            return self.number != nil
        }) { (validated) in
            if !validated {throw CreditCardError.missingParameter("number")}
        }
        
        let numberValidation = Validation.init(validable: {
            return self.number!.count == 16 && (try! Regex.init(pattern: Schemes.Regex.visa).parse(input: self.number!))
        }, validated: { (validated) in
            if !validated {throw CreditCardError.numberFormatError}
        })
        
        let missingYearValidation = Validation.init(validable: {
            return self.expYear != nil
        }) { (validated) in
            if !validated {throw CreditCardError.missingParameter("year")}
        }
        
        let yearValidation = Validation.init(validable: {
            return 2000 + Int(self.expYear!) >= Date.currentYear()
        }) { (validated) in
            if !validated {throw CreditCardError.invalidYear}
        }
        
        let missingMonthValidation = Validation.init(validable: {
            return self.expMonth != nil
        }) { (validated) in
            if !validated {throw CreditCardError.missingParameter("month")}
        }
        
        let monthValidation = Validation.init(validable: {
            return (Int(self.expYear!) + 2000 == Date.currentYear() && self.expMonth! >= Date.currentMonth()) || (Int(self.expYear!) + 2000 > Date.currentYear() && self.expMonth! <= 12)
        }) { (validated) in
            if !validated {
                throw CreditCardError.invalidMonth
            }
        }
        
        let missingCVVValidation = Validation.init(validable: {
            return self.cvc != nil && !self.cvc!.isEmpty
        }) { (validated) in
            if !validated {throw CreditCardError.missingParameter("cvc")}
        }
        
        let cvvValidation = Validation.init(validable: {
            return try! Regex.init(pattern: Schemes.Regex.cvv).parse(input: self.cvc!)
        }) { (validated) in
            if !validated {throw CreditCardError.invalidCVV}
        }
        
        let nameValidation = Validation(validable: { () -> Bool in
            return self.name != nil && !self.name!.isEmpty
        }) { (validated) in
            if !validated { throw CreditCardError.missingParameter("name") }
        }
        
        validator.add(missingNumberValidation)
        validator.add(numberValidation)
        validator.add(missingMonthValidation)
        validator.add(missingYearValidation)
        validator.add(yearValidation)
        validator.add(monthValidation)
        validator.add(missingCVVValidation)
        validator.add(cvvValidation)
        validator.add(nameValidation)
    }
}

extension CreditCard {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case number
        case name
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case cvc
    }
}
