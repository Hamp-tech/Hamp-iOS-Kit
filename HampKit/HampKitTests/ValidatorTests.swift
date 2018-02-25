//
//  ValidatorTests.swift
//  HampiOSKitTests
//
//  Created by Joan Molinas Ramon on 24/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class ValidatorTests: XCTestCase {
	func testValidateTrue() {
		let validator = Validator()
		let validation = Validation(validable: { () -> Bool in
			return true
		}) { (validated) in
			XCTAssertTrue(validated)
		}
		
		validator.add(validation)
		try? validator.validate()
	}
	
	func testValidateFalse() {
		let validator = Validator()
		let validation = Validation(validable: { () -> Bool in
			return false
		}) { (validated) in
			XCTAssertFalse(validated)
		}
		
		validator.add(validation)
		try? validator.validate()
	}
	
	func testValidateThrowAnError() {
		enum Foo: Error {
			case bar
		}
		
		let validator = Validator()
		let validation = Validation(validable: { () -> Bool in
			return false
		}) { (validated) in
			throw Foo.bar
		}
		
		validator.add(validation)
		XCTAssertThrowsError(try validator.validate())
	}
}
