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
        if !(HMPManager.sharedManager?.configured)! {
            HMPManager.sharedManager?.connect()
        }
        expectedUser = HMPFirebaseUser(uid: "EdsmCnKNbte96H927URdTeOYVH62", email: "test@test.com")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSigninWithEmailPassword_True_AllValid() {
        let exp = self.expectation(description: "Sign in correct")
        HMPFirebaseAuth.signIn(
            withEmail: "test@test.com",
            password: "arcanine",
            onSuccess: { (user) in
                XCTAssertEqual(user, self.expectedUser!)
                exp.fulfill()
        },  onError: { (error) in
            XCTAssertTrue(false)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testSigninWithEmailPassword_True_Error17009() {
        let exp = self.expectation(description: "Sign in error 17009")
        HMPFirebaseAuth.signIn(
            withEmail: "test@test.com",
            password: "arcanine1",
            onSuccess: { (user) in
                XCTAssertTrue(false)
                exp.fulfill()
        },  onError: { (error) in
            XCTAssertEqual(error as! HMPFirebaseAuth.AuthError, HMPFirebaseAuth.AuthError.wrongPassword)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testCreateUserWithEmailPassword_AllValid() {
        //If fire onErrorBlock, run again the test
        
        let exp = self.expectation(description: "New user correct")
        
        HMPFirebaseAuth.createUser(
            withEmail: "test\(arc4random_uniform(100)+1)@test.com",
            password: "123456789",
            onSuccess: { (user) in
                XCTAssertTrue(user.uid.count > 0)
                XCTAssertTrue(user.email.count > 0)
                exp.fulfill()
        }, onError: { (error) in
            XCTAssertFalse(true)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testCreateUserWithEmailPassword_Error17007() {
        let exp = self.expectation(description: "New user error 17007")
        
        HMPFirebaseAuth.createUser(
            withEmail: "test@test.com",
            password: "123456789",
            onSuccess: { (user) in
                XCTAssertFalse(true)
                exp.fulfill()
        }, onError: { (error) in
            XCTAssertEqual(error as! HMPFirebaseAuth.AuthError, HMPFirebaseAuth.AuthError.emailAlreadyInUse)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testCreateUserWithEmailPassword_Error17026() {
        let exp = self.expectation(description: "New user error 17026")
        
        HMPFirebaseAuth.createUser(
            withEmail: "test1@test.com",
            password: "123",
            onSuccess: { (user) in
                XCTAssertFalse(true)
                exp.fulfill()
        }, onError: { (error) in
            XCTAssertEqual(error as! HMPFirebaseAuth.AuthError, HMPFirebaseAuth.AuthError.weakPassword)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testCreateUserWithEmailPassword_Error17008() {
        let exp = self.expectation(description: "New user error 17008")
        
        HMPFirebaseAuth.createUser(
            withEmail: "test1",
            password: "1232345341",
            onSuccess: { (user) in
                XCTAssertFalse(true)
                exp.fulfill()
        }, onError: { (error) in
            XCTAssertEqual(error as! HMPFirebaseAuth.AuthError, HMPFirebaseAuth.AuthError.invalidEmail)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testSignOut_AllValid() {
        //Execute sign in first
        
        let exp = self.expectation(description: "Sign out correct")
        
        HMPFirebaseAuth.signIn(
            withEmail: "test@test.com",
            password: "arcanine",
            onSuccess: { (user) in
                XCTAssertEqual(user, self.expectedUser!)
                exp.fulfill()
                
                XCTAssertNotNil(HMPFirebaseAuth.currentUser())
                
                HMPFirebaseAuth.signOut(
                    onSuccess: {
                        XCTAssertNil(HMPFirebaseAuth.currentUser())
                },  onError: { (error) in
                        XCTAssertFalse(true)
                })
        }, onError: { (error) in
            XCTAssertTrue(false)
            exp.fulfill()
        })
        
        
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testSignOut_Error17011() {
        
        let exp = self.expectation(description: "Sign out error 17011")
        
        HMPFirebaseAuth.signOut(onSuccess: {
            XCTAssertTrue(false)
            exp.fulfill()
        }, onError : { (error) in
            XCTAssertEqual(error as! HMPFirebaseAuth.AuthError, HMPFirebaseAuth.AuthError.userNotFound)
            exp.fulfill()
        })
        
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}


