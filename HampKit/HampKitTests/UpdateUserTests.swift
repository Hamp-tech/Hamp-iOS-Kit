//
//  UpdateUserTests.swift
//  HampiOSKitTests
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class UpdateUserTests: XCTestCase {
    
    func testUpdateUser() {
        let raw = """
        {
            "name": "Joan"
        }
        """
        let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: raw.data(using: .utf8)!)
        
        user.identifier = "995828f80c7d4479a8caf3a90079d0e8"
        let response = Response<User>(code: .ok, message: "User updated successfully")
        let session = URLSessionMock(data: response.toData)
        
        let userRequester = UserRequester(session: session)
        
        let updateExpectation = expectation(description: "Update user expectation")
        
        userRequester.update(user: user) { (response) in
            XCTAssertEqual(response.code, .ok)
            XCTAssertEqual(response.message, "User updated successfully")
            XCTAssertNil(response.data)
            updateExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testUpdateUserError() {
        let raw = """
        {
            "name": "Joan"
        }
        """
        let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: raw.data(using: .utf8)!)
        
        user.identifier = "995828f80c7d4479a8caf3a90079d0e8"
        
        let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
        let session = URLSessionMock(error: error)
        
        let userRequester = UserRequester(session: session)
        userRequester.update(user: user) { (response) in
            XCTAssertEqual(response.code, .internalError)
        }
    }
    
    func testUserCreateCreditCard() {
        let raw = """
            {
                "name": "Elon Musk",
                "number": "4242424242424242",
                "exp_month": 12,
                "exp_year": 23,
                "cvc": "444"
            }
        """
        
        let rawRequest = """
        {
            "message": "Card created successfully",
            "data": {
                "id": "card_1ByhtoCiVhDLJHAGYIBbYwI9",
                "number": "4242",
                "exp_year": 23,
                "exp_month": 12
            },
            "code": 200
        }
        """
        
        let card = try! Singletons.sharedJSONDecoder.decode(CreditCard.self, from: raw.data(using: .utf8)!)
        let response = try! Singletons.sharedJSONDecoder.decode(Response<CreditCard>.self, from: rawRequest.data(using: .utf8)!)
        
        let session = URLSessionMock(data: response.toData)
        let requester = UserRequester(session: session)
        
        let creditCardExpectation = expectation(description: "Create credit card expectation")
        
        
        requester.createCreditCard(userIdentifier: "995828f80c7d4479a8caf3a90079d0e8", card: card) { (response) in
            XCTAssertEqual(response.code, .ok)
            XCTAssertEqual(response.message, "Card created successfully")
            XCTAssertNotNil(response.data?.identifier)
            XCTAssertEqual(response.data?.number, "4242")
            XCTAssertEqual(response.data?.expYear, 23)
            XCTAssertEqual(response.data?.expMonth, 12)
            creditCardExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testCreateCreditCardError() {
        let raw = """
            {
                "number": "4242424242424242",
                "exp_month": 12,
                "exp_year": 23,
                "cvc": "444"
            }
        """
        let card = try! Singletons.sharedJSONDecoder.decode(CreditCard.self, from: raw.data(using: .utf8)!)
        
        let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
        let session = URLSessionMock(error: error)
        let requester = UserRequester(session: session)
    
        requester.createCreditCard(userIdentifier: "995828f80c7d4479a8caf3a90079d0e8", card: card) { (response) in
            XCTAssertEqual(response.code, .internalError)
        }
    }
    
    func testRemoveCreditCard() {
        
        let response = Response<String>(code: .ok, message: "Card removed successfully")
        let session = URLSessionMock(data: response.toData)
        
        let requester = UserRequester(session: session)
        
        let removeCreditCardExpectation = expectation(description: "Remove credit card expectation")
        
        requester.deleteCreditCard(userIdentifier: "995828f80c7d4479a8caf3a90079d0e8", cardIdentifier: "card_1ByhyECiVhDLJHAGOB7a9KeW") { (response) in
            XCTAssertEqual(response.code, .ok)
            XCTAssertEqual(response.message, "Card removed successfully")
            removeCreditCardExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testRemoveCreditError() {
        
        let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
        let session = URLSessionMock(error: error)
        
        let requester = UserRequester(session: session)
    
        requester.deleteCreditCard(userIdentifier: "995828f80c7d4479a8caf3a90079d0e8", cardIdentifier: "card_1ByhyECiVhDLJHAGOB7a9KeW") { (response) in
            XCTAssertEqual(response.code, .internalError)
        }
    }
}
