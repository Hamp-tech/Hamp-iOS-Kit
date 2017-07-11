//
//  HampFirebaseAuth.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public typealias SuccessBlockWithUser = ((HampFirebaseUser) -> ())?
public typealias ErrorBlock = ((Error) -> ())?
public typealias SuccessBlock = (() -> ())?

public struct HampFirebaseAuth {
    
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
            } else {
                Auth.auth().addStateDidChangeListener({ (auth, user) in
                    if let user = user {
                        let u = HampFirebaseUser(uid: user.uid, email: user.email!)
                        onSuccess?(u)
                    }
                })
                
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
            if let e = error {
                let code = (e as NSError).code
                let authError = AuthError(rawValue: code)
                onError?(authError)
            } else {
                let user = HampFirebaseUser(uid: user!.uid, email: user!.email!)
                onSuccess?(user)
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
        
        guard let _ = currentUser() else {
            onError?(AuthError.userNotFound)
            return
        }
        
        do {
            try Auth.auth().signOut()
            Auth.auth().addStateDidChangeListener({ (auth, user) in
                onSuccess?()
            })
        } catch let signOutError as NSError {
            onError?(AuthError.init(rawValue: signOutError.code))
        } catch {
            onError?(AuthError.unknown)
            
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
            if let e = error {
                let code = (e as NSError).code
                let authError = AuthError(rawValue: code)
                onError?(authError)
            } else {
                let user = HampFirebaseUser(uid: user!.uid, email: user!.email!)
                onSuccess?(user)
            }
        }
    }
}

extension HampFirebaseAuth {
    /// Check if manager is configured.
    /// - If isn't configured, fire assert
    private static func managerConfiguredChecker() {
        assert(HampFirebaseManager.productionManager!.configured, "Connect HampFirebaseManager")
    }
}

extension HampFirebaseAuth {
    public static func currentUser() -> HampFirebaseUser?{
        guard let user = Auth.auth().currentUser else { return nil }
        
        return HampFirebaseUser(uid: user.uid, email: user.email!)
    }
}

extension HampFirebaseAuth {
    /// Errors indicating the different problems authenticating users
    /// https://firebase.google.com/docs/reference/ios/firebaseauth/api/reference/Enums/FIRAuthErrorCode
    public enum AuthError : Swift.Error, CustomStringConvertible, Equatable {
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
        
        public static func ==(lhs: AuthError, rhs: AuthError) -> Bool {
            return lhs.code == rhs.code
        }
    }
}

