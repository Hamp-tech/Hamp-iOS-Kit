//
//  HMPAuth.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public typealias SuccessBlock = ((HMPUser) -> ())?
public typealias ErrorBlock = ((Error) -> ())?

public struct HMPAuth {
    
    /// Log in to firebase
    ///
    /// - Parameters:
    ///   - mail: email to log in
    ///   - password: password to log in
    ///   - successBlock: block called if all was successfull
    ///   - errorBlock: block called if error ocurred
    public static func signIn(
        mail : String,
        password : String,
        successBlock: SuccessBlock,
        errorBlock: ErrorBlock) {
        
        managerConfiguredChecker()
    }
    
    /// Sign up to firebase
    ///
    /// - Parameters:
    ///   - mail: email to log in
    ///   - password: password to log in
    ///   - successBlock: block called if all was successfull
    ///   - errorBlock: block called if error ocurred
    public static func signUp(
        mail : String,
        password : String,
        successBlock: SuccessBlock,
        errorBlock: ErrorBlock) {
        
        managerConfiguredChecker()
        
    }
    
    /// Sign out on firebase
    ///
    /// - Parameters:
    ///   - success: block called if all was successfull
    ///   - error: block called if error ocurred
    public static func signOut(
        success : SuccessBlock,
        error : ErrorBlock) {
        
        managerConfiguredChecker()
        
    }
    
    /// Log in to firebase
    ///
    /// - Parameters:
    ///   - accessToken: token retrieved from facebook sdk
    ///   - successBlock: block called if all was successfull
    ///   - errorBlock: block called if error ocurred
    public static func singInWithFacebook(
        accessToken : String,
        successBlock: SuccessBlock,
        errorBlock: ErrorBlock) {
        
        managerConfiguredChecker()
        
    }
}

extension HMPAuth {
    /// Check if manager is configured.
    /// - If isn't configured, fire assert
    private static func managerConfiguredChecker() {
        assert(HMPManager.sharedManager!.configured, "Connect HMPManager")
    }
}
