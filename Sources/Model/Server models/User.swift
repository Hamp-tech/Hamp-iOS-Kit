//
//  User.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class User: Objectable {
	
	// MARK: - Properties
	public var identifier: String?
	public var name: String?
	public var surname: String?
	public var email: String?
	public var password: String?
	public var phone: String?
	public var birthday: String?
	public var gender: String?
	public var tokenFCM: String?
	public var os: String?
	public var language: String?
	public var cards: [CreditCard]?
	
	private var validator = Validator()
	
	private enum CodingKeys: String, CodingKey {
		case identifier
		case name
		case surname
		case email
		case password
		case phone
		case birthday
		case gender
		case tokenFCM
		case os
		case language
		case cards
	}
	
	// MARK: - Life cycle
	public init(identifier: String? = nil,
		 name: String? = nil,
		 surname: String? = nil,
		 email: String? = nil,
		 password: String? = "",
		 phone: String? = nil,
		 birthday: String? = nil,
		 gender: String? = nil,
		 tokenFCM: String? = nil,
		 os: String? = nil,
		 language: String? = nil,
		 cards: [CreditCard]? = nil) {
		
		self.identifier = identifier
		self.name = name
		self.surname = surname
		self.email = email
		self.password = password
		self.phone = phone?.replacingOccurrences(of: " ", with: "")
		self.birthday = birthday
		self.gender = gender
		self.tokenFCM = tokenFCM
		self.os = os
		self.language = language
		self.cards = cards
        
        self.addValidations()
	}
    
    public init() {
        self.addValidations()
    }
	
	// MARK: - Objectable
	public func validate() throws {
		try validator.validate()
	}
    
    private func addValidations() {
        let nameValidation = Validation(validable: { [unowned self] () -> Bool in
            return self.name != nil && self.name!.count > 0
            }, validated: { (validated) in
                if !validated { throw UserError.missingParameter("name") }
        })
        
        let surnameValidation = Validation(validable: { () -> Bool in
            return self.surname != nil && self.surname!.count > 0
        }) { (validated) in
            if !validated { throw UserError.missingParameter("surname") }
        }
        
        let missingEmailValidation = Validation(validable: { () -> Bool in
            return self.email != nil
        }) { (validated) in
            if !validated { throw UserError.missingParameter("email") }
        }
        
        let emailFormatValidation = Validation.init(validable: {
            return (try! Regex(pattern: Schemes.Regex.email).parse(input: self.email!))
        }) { (validated) in
            if !validated {throw UserError.emailFormatError}
        }
        
        let missingPasswordValidation = Validation.init(validable: {
            return self.password != nil && self.password!.count > 0
        }) { (validated) in
            if !validated {throw UserError.missingParameter("password")}
        }
        
        let missingPhoneValidation = Validation.init(validable: {
            return self.phone != nil
        }) { (validated) in
            if !validated { throw UserError.missingParameter("phone") }
        }
        
        let phoneFormatValidation = Validation.init(validable: {
            return try! Regex(pattern: Schemes.Regex.phone).parse(input: self.phone!)
        }) { (validated) in
            if !validated {throw UserError.phoneFormatError}
        }
        
        let missingBirthdayValidation = Validation.init(validable: {
            return self.birthday != nil
        }) { (validated) in
            if !validated {throw UserError.missingParameter("birthday")}
        }
        
        let missingGenderValidation = Validation.init(validable: {
            return self.gender != nil && self.gender!.count == 1
        }) { (validated) in
            if !validated {throw UserError.missingParameter("gender")}
        }
        
        validator.add(nameValidation)
        validator.add(surnameValidation)
        validator.add(missingEmailValidation)
        validator.add(emailFormatValidation)
        if password != nil { validator.add(missingPasswordValidation) }
        validator.add(missingPhoneValidation)
        validator.add(phoneFormatValidation)
        validator.add(missingBirthdayValidation)
        validator.add(missingGenderValidation)
    }
}

extension User: CustomStringConvertible {
	public var description: String {
		var desc = "<User>"
		desc += dict.description
		return desc
	}
}
