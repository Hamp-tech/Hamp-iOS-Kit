//
//  User.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

class User: Objectable {
	
	// MARK: - Properties
	var identifier: String?
	var name: String?
	var surname: String?
	var email: String?
	var password: String?
	var phone: String?
	var birthday: String?
	var gender: String?
	var tokenFCM: String?
	var os: String?
	var language: String?
	var cards: [CreditCard]?
	
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
	init(identifier: String? = nil,
		 name: String? = nil,
		 surname: String? = nil,
		 email: String? = nil,
		 password: String? = nil,
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
		self.phone = phone
		self.birthday = birthday
		self.gender = gender
		self.tokenFCM = tokenFCM
		self.os = os
		self.language = language
		self.cards = cards
        
        self.addValidations()
	}
    
    init() {
        self.addValidations()
    }
	
	// MARK: - Objectable
	func validate() throws {
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
        
        let emailValidation = Validation(validable: { () -> Bool in
            return self.email != nil && (try! Regex(pattern: Schemes.Regex.email).parse(input: self.email!))
        }) { (validated) in
            if !validated { throw UserError.missingParameter("email") }
        }
        
        validator.add(nameValidation)
        validator.add(surnameValidation)
        validator.add(emailValidation)
    }
}

extension User: CustomStringConvertible {
	var description: String {
		var desc = "<User>"
		desc += dict.description
		return desc
	}
}