//
//  AuthTests.swift
//  HampiOSKitTests
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class AuthTests: XCTestCase {
    
    func testSignInSuccess() {
        
        let responseJSON =
        """
            {
            "message": "",
            "data": {
                "phone": "666777888",
                "gender": "M",
                "cards": [],
                "surname": "Musk",
                "email": "elon@usehamp1.io",
                "identifier": "e33577a075a44f7d8094b0c8edfac85b",
                "name": "Elon"
            },
            "code": 200
        }
        """
        
        let response = try! Singletons.sharedJSONDecoder.decode(Response<User>.self, from: responseJSON.data(using: .utf8)!)
        let session = URLSessionMock(data: response.json.data(using: .utf8))
        
        let singinExpectation = expectation(description: "Sign in expectation")
        
        let requester = AuthRequester(session: session)
        requester.singIn(email: "elon1@usehamp.io", password: "1234567890") { (resp) in
            XCTAssertEqual(resp.code, response.code)
            XCTAssertNotNil(resp.data)
            XCTAssertNotNil(resp.data?.identifier)
            XCTAssertEqual(resp.data?.name, response.data?.name)
            XCTAssertEqual(resp.data?.gender, response.data?.gender)
            XCTAssertEqual(resp.data?.surname, response.data?.surname)
            XCTAssertEqual(resp.data?.phone, response.data?.phone)
            XCTAssertEqual(resp.data?.email, response.data?.email)
            XCTAssertEqual(resp.data?.dict.count, 8)
            
            do {
                try response.data!.validate()
                XCTAssertTrue(true)
            } catch {
                print(error.localizedDescription)
                XCTAssertFalse(true)
            }
            
            singinExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testSingInUserDoesntExists() {
        let responseWaited = Response<User>(code: HTTPCode.notFound, message: "User doesn't exists")
        let session = URLSessionMock(data: responseWaited.json.data(using: .utf8))
        
        let signinExpectation = expectation(description: "Sign in error expectation")
        let authRequester = AuthRequester(session: session)
        authRequester.singIn(email: "mark@usehamp.io", password: "1234567890") { (response) in
            XCTAssertEqual(response.code, responseWaited.code)
            XCTAssertNil(response.data)
            XCTAssertEqual(response.message, responseWaited.message)
            signinExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testSignInError() {
        let e = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
        let session = URLSessionMock(error: e)
        
        let authRequester = AuthRequester(session: session)
        authRequester.singIn(email: "elon@usehamp.io", password: "1234567890") { (response) in
            XCTAssertEqual(response.code, .internalError)
            XCTAssertNil(response.data)
            XCTAssertNotNil(response.message)
        }
    }
    
    func testUserSignup() {
        let userJSON =
        """
            {
                "name" : "Elon",
                "surname" : "Musk",
                "email" : "elon@usehamp1.io",
                "password" : "1234567890",
                "phone" : "666777888",
                "gender" : "M",
                "tokenFCM" : "834hhfjkhsdkhsfk8348738975hf",
                "os" : "ios",
                "language" : "esES"
            }
        """
        
        let responseJSON =
        """
            {
            "message": "",
            "data": {
                "phone": "666777888",
                "gender": "M",
                "cards": [],
                "surname": "Musk",
                "email": "elon@usehamp1.io",
                "identifier": "e33577a075a44f7d8094b0c8edfac85b",
                "name": "Elon"
            },
            "code": 200
        }
        """
        let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: userJSON.data(using: .utf8)!)
        let responseWaited = try! Singletons.sharedJSONDecoder.decode(Response<User>.self, from: responseJSON.data(using: .utf8)!)
        
        let session = URLSessionMock(data: responseJSON.data(using: .utf8)!)
        
        let signupExpectation = expectation(description: "Signup expectation")
        let requester = AuthRequester(session: session)
        
        requester.signUp(user: user) { (response) in
            XCTAssertEqual(response.code, responseWaited.code)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.data?.identifier)
            XCTAssertEqual(response.data?.name, responseWaited.data?.name)
            XCTAssertEqual(response.data?.surname, responseWaited.data?.surname)
            XCTAssertEqual(response.data?.email, responseWaited.data?.email)
            XCTAssertEqual(response.data?.gender, responseWaited.data?.gender)
            XCTAssertEqual(response.data?.phone, responseWaited.data?.phone)
            XCTAssertTrue(response.data!.cards!.isEmpty)
            XCTAssertNotNil(responseWaited.data?.identifier)
            XCTAssertEqual(response.data?.dict.count, 8)
            
            do {
                try response.data!.validate()
                XCTAssertTrue(true)
            } catch {
                XCTAssertFalse(true)
            }
            
            signupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testSignupUserExists() {
        let userJSON =
        """
            {
                "name" : "Elon",
                "surname" : "Musk",
                "email" : "elon@usehamp1.io",
                "password" : "1234567890",
                "phone" : "666777888",
                "gender" : "M",
                "tokenFCM" : "834hhfjkhsdkhsfk8348738975hf",
                "os" : "ios",
                "language" : "esES"
            }
        """
        
        let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: userJSON.data(using: .utf8)!)
        let responseWaited = Response<User>(code: HTTPCode.conflict, message: "User already exists")
        
        let session = URLSessionMock(data: responseWaited.json.data(using: .utf8))
        
        let authRequester = AuthRequester(session: session)
        authRequester.signUp(user: user) { (response) in
            XCTAssertEqual(response.code, responseWaited.code)
            XCTAssertEqual(response.message, responseWaited.message)
            XCTAssertNil(response.data)
        }
    }
    
    func testSignUpError() {
        let userJSON =
        """
            {
                "name" : "Elon",
                "surname" : "Musk",
                "email" : "elon@usehamp1.io",
                "password" : "1234567890",
                "phone" : "666777888",
                "gender" : "M",
                "tokenFCM" : "834hhfjkhsdkhsfk8348738975hf",
                "os" : "ios",
                "language" : "esES"
            }
        """
        
        let user = try! Singletons.sharedJSONDecoder.decode(User.self, from: userJSON.data(using: .utf8)!)
        
        let e = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
        let session = URLSessionMock(error: e)
        
        let authRequester = AuthRequester(session: session)
        authRequester.signUp(user: user) { (response) in
            XCTAssertEqual(response.code, .internalError)
            XCTAssertNil(response.data)
            XCTAssertNotNil(response.message)
        }
    }
}
