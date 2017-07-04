//
//  HMPAuth.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public typealias SuccessBlock = ((HMPFirebaseUser) -> ())?
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
        withEmail email : String,
        password : String,
        successBlock: SuccessBlock,
        errorBlock: ErrorBlock) {
        
        managerConfiguredChecker()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            print(user as Any)
            if let e = error, let eBlock = errorBlock {
                let code = (e as NSError).code
                let authError = AuthError.error(by : code)
                eBlock(authError)
            } else if let sBlock = successBlock {
                let user = HMPFirebaseUser(uid: user!.uid, email: user!.email!)
                sBlock(user)
            }
        }
    }
    
    /// Sign up to firebase
    ///
    /// - Parameters:
    ///   - mail: email to log in
    ///   - password: password to log in
    ///   - successBlock: block called if all was successfull
    ///   - errorBlock: block called if error ocurred
    public static func signUp(
        withEmail email : String,
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
        successBlock : SuccessBlock,
        errorBlock : ErrorBlock) {
        
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

extension HMPAuth {
    /// Errors indicating the different problems authenticating users
    ///
    /// - ConnectionUnavailable: Connection to internet not reachable
    /// - BadCredentials: Email or password wrong
    /// https://firebase.google.com/docs/reference/ios/firebaseauth/api/reference/Enums/FIRAuthErrorCode
    public enum AuthError : Swift.Error, CustomStringConvertible {
        case UserDisabled
        case EmailAlreadyInUse
        case InvalidEmail
        case WrongPassword
        case UserNotFound
        case RecentLogin
        case NetworkError
        case WeakPassword
        case Unknown
        
        /// Code number for each error
        public var code : Int {
            switch self {
            case .UserDisabled:
                return 17005
            case .EmailAlreadyInUse:
                return 17007
            case .InvalidEmail:
                return 17008
            case .WrongPassword:
                return 17009
            case .UserNotFound:
                return 17011
            case .RecentLogin:
                return 17014
            case .NetworkError:
                return 17020
            case .WeakPassword:
                return 17026
            case .Unknown:
                return 17999
            }
        }
        
        /// Return an error by code
        ///
        /// - Parameter code: error code
        /// - Returns: AuthError indicating error for the parameters code
        public static func error(by code: Int) -> AuthError {
            switch code {
            case 17005:
                return .UserDisabled
            case 17007:
                return .EmailAlreadyInUse
            case 17008:
                return .InvalidEmail
            case 17009:
                return .WrongPassword
            case 17011:
                return .UserNotFound
            case 17014:
                return .RecentLogin
            case 17020:
                return .NetworkError
            case 17026:
                return .WeakPassword
            default :
                return .Unknown
            }
        }
        
        public var description: String {
            switch self {
            case .UserDisabled:
                return "17005"
            case .EmailAlreadyInUse:
                return "17007"
            case .InvalidEmail:
                return "17008"
            case .WrongPassword:
                return "17009"
            case .UserNotFound:
                return "17011"
            case .RecentLogin:
                return "17014"
            case .NetworkError:
                return "17020"
            case .WeakPassword:
                return "17026"
            case .Unknown:
                return "17999"
            }
        }
        
    }
}

