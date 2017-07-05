//
//  HMPAuth.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public typealias SuccessBlockWithUser = ((HMPFirebaseUser) -> ())?
public typealias ErrorBlock = ((Error) -> ())?
public typealias SuccessBlock = (() -> ())?

public struct HMPAuth {
    
    /// Log in to firebase
    ///
    /// - Parameters:
    ///   - mail: email to log in
    ///   - password: password to log in
    ///   - onSuccess: block called if all was successfull
    ///   - onError: block called if error ocurred
    public static func signIn(
        withEmail email: String,
        password: String,
        onSuccess: SuccessBlockWithUser = nil,
        onError: ErrorBlock = nil) {
        
        managerConfiguredChecker()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let e = error, let eBlock = onError {
                let code = (e as NSError).code
                let authError = AuthError(rawValue: code)
                eBlock(authError)
            } else if let sBlock = onSuccess {
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
    ///   - onSuccess: block called if all was successfull
    ///   - onError: block called if error ocurred
    public static func createUser(
        withEmail email: String,
        password: String,
        onSuccess: SuccessBlockWithUser = nil,
        onError: ErrorBlock = nil) {
        
        managerConfiguredChecker()
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error, let eBlock = onError {
                let code = (e as NSError).code
                let authError = AuthError(rawValue: code)
                eBlock(authError)
            } else if let sBlock = onSuccess {
                let user = HMPFirebaseUser(uid: user!.uid, email: user!.email!)
                sBlock(user)
            }
        }
        
    }
    
    /// Sign out on firebase
    ///
    /// - Parameters:
    ///   - onSuccess: block called if all was successfull
    ///   - onError: block called if error ocurredd
    public static func signOut(
        onSuccess: SuccessBlock = nil,
        onError: ErrorBlock = nil) {
        
        managerConfiguredChecker()
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            if let eBlock = onError { eBlock(AuthError.init(rawValue: signOutError.code))}
        } catch {
            if let eBlock = onError {eBlock(AuthError.unknown) }
        }
        
    }
    
    //TODO: Tests
    /// Log in to firebase
    ///
    /// - Parameters:
    ///   - accessToken: token retrieved from facebook sdk
    ///   - onSuccess: block called if all was successfull
    ///   - onError: block called if error ocurredd
    public static func singInWithFacebook(
        accessToken: String,
        onSuccess: SuccessBlockWithUser = nil,
        onError: ErrorBlock = nil) {
        
        managerConfiguredChecker()
        
        let facebookCredentials = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: facebookCredentials) { (user, error) in
            if let e = error, let eBlock = onError {
                let code = (e as NSError).code
                let authError = AuthError(rawValue: code)
                eBlock(authError)
            } else if let sBlock = onSuccess {
                let user = HMPFirebaseUser(uid: user!.uid, email: user!.email!)
                sBlock(user)
            }
        }
        
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
    /// https://firebase.google.com/docs/reference/ios/firebaseauth/api/reference/Enums/FIRAuthErrorCode
    public enum AuthError : Swift.Error, CustomStringConvertible {
        case userDisabled
        case emailAlreadyInUse
        case invalidEmail
        case wrongPassword
        case userNotFound
        case recentLogin
        case networkError
        case weakPassword
        case unknown
        
        /// Instance new error by code
        ///
        /// - Parameter rawValue: <#rawValue description#>
        init(rawValue: Int) {
            switch rawValue {
            case 17005: self = .userDisabled
            case 17007: self = .emailAlreadyInUse
            case 17008: self = .invalidEmail
            case 17009: self = .wrongPassword
            case 17011: self = .userNotFound
            case 17014: self = .recentLogin
            case 17020: self = .networkError
            case 17026: self = .weakPassword
            default: self = .unknown
            }
        }
        
        /// Code number for each error
        public var code : Int {
            switch self {
            case .userDisabled:
                return 17005
            case .emailAlreadyInUse:
                return 17007
            case .invalidEmail:
                return 17008
            case .wrongPassword:
                return 17009
            case .userNotFound:
                return 17011
            case .recentLogin:
                return 17014
            case .networkError:
                return 17020
            case .weakPassword:
                return 17026
            case .unknown:
                return 17999
            }
        }
        
        public var description: String {
            switch self {
            case .userDisabled:
                return "17005"
            case .emailAlreadyInUse:
                return "17007"
            case .invalidEmail:
                return "17008"
            case .wrongPassword:
                return "17009"
            case .userNotFound:
                return "17011"
            case .recentLogin:
                return "17014"
            case .networkError:
                return "17020"
            case .weakPassword:
                return "17026"
            case .unknown:
                return "17999"
            }
        }
        
    }
}

