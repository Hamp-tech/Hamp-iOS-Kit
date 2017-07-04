//
//  HampKitAuthTests.swift
//  HampKitTests
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class HampKitAuthTests: XCTestCase {
    
    var expectedUser : HMPFirebaseUser!
    var connected = false
    
    override func setUp() {
        super.setUp()
        if !connected {
            HMPManager.sharedManager?.connect()
            connected = true
        }
        expectedUser = HMPFirebaseUser(uid: "EdsmCnKNbte96H927URdTeOYVH62", email: "test@test.com")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSigninWithEmailPassword_True_AllValid() {
        let exp = self.expectation(description: "myExpectation")
        
        HMPAuth.signIn(
            withEmail: "test@test.com",
            password: "arcanine",
            onSuccess: { (user) in
                XCTAssertEqual(user, self.expectedUser!)
                exp.fulfill()
        },
            onError: { (error) in
                XCTAssertTrue(false)
                exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

