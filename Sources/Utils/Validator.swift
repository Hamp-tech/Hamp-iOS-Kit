//
//  Validator.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 24/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

final class Validation {
	typealias Validable = () -> Bool
	typealias Validated = (Bool) throws -> Void
	
	
	var validable: Validable
	var validated: Validated
	
	init(validable: @escaping Validable, validated: @escaping Validated) {
		self.validable = validable
		self.validated = validated
	}
}

final class Validator {
	
	// MARK: - Properties
	private var validations = [Validation]()
	
	
	// MARK: - Public api
	func add(_ validation: Validation) {
		validations.append(validation)
	}
	
	func validate() throws {
		try validations.forEach {
			let a = $0.validable()
			try $0.validated(a)
		}
	}
}
