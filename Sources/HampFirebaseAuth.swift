//
//  HampFirebaseAuth.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import FirebaseCommunity

public typealias AuthSuccessWithUser = ((HampFirebaseUser) -> ())?
public typealias AuthSuccess = (() -> ())?
public typealias AuthError = ((Error) -> ())?


internal struct HampFirebaseAuth {
    
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
        onSuccess: AuthSuccessWithUser = nil,
        onError: AuthError = nil) {
        
        managerConfiguredChecker()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let e = error, let eBlock = onError {
                let code = (e as NSError).code
                let authError = AuthResponseError(rawValue: code)
                eBlock(authError!)
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
        onSuccess: AuthSuccessWithUser = nil,
        onError: AuthError = nil) {
        
        managerConfiguredChecker()
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error {
                let code = (e as NSError).code
                let authError = AuthResponseError(rawValue: code)
                onError?(authError!)
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
        onSuccess: AuthSuccess = nil,
        onError: AuthError = nil) {
        
        managerConfiguredChecker()
        
        guard let _ = currentUser() else {
            onError?(AuthResponseError.userNotFound)
            return
        }
        
        do {
            try Auth.auth().signOut()
            Auth.auth().addStateDidChangeListener({ (auth, user) in
                onSuccess?()
            })
        } catch let signOutError as NSError {
            onError?(AuthResponseError(rawValue: signOutError.code)!)
        } catch {
            onError?(AuthResponseError.unknown)
            
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
        onSuccess: AuthSuccessWithUser = nil,
        onError: AuthError = nil) {
        
        managerConfiguredChecker()
        
        let facebookCredentials = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: facebookCredentials) { (user, error) in
            if let e = error {
                let code = (e as NSError).code
                let authError = AuthResponseError(rawValue: code)
                onError?(authError!)
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
        assert(HampFirebaseManager.shared!.configured, "Connect HampFirebaseManager")
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
    public enum AuthResponseError : Int, Swift.Error, CustomStringConvertible, Equatable {
        case userDisabled = 17005
        case emailAlreadyInUse = 17007
        case invalidEmail = 17008
        case wrongPassword = 17009
        case userNotFound = 17011
        case recentLogin = 17014
        case networkError = 17020
        case weakPassword = 17026
        case unknown = 17999
        
        /// Code number for each error
        public var code : Int {
            return self.rawValue
        }
        
        public var description: String {
            switch self {
            case .userDisabled:
                return "User is disabled"
            case .emailAlreadyInUse:
                return "Email already exists"
            case .invalidEmail:
                return "Invalid email"
            case .wrongPassword:
                return "Wrong password"
            case .userNotFound:
                return "User with this credentials doesn't exists"
            case .recentLogin:
                return "You change your email or password 5 minuts or more after signing in"
            case .networkError:
                return "An network error occurred"
            case .weakPassword:
                return "Password is weak"
            case .unknown:
                return "Unknown error"
            }
        }
        
        public static func ==(lhs: AuthResponseError, rhs: AuthResponseError) -> Bool {
            return lhs.code == rhs.code
        }
    }
}

