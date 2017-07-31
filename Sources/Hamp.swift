//
//  Hamp.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 25/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct Hamp {
    //MARK: Properties
    /// Environtment to managers
    public static var environtment: HampEnvironment! {
        didSet {
            HampServerManager.environtment = environtment
            HampFirebaseManager.environtment = environtment
        }
    }
    
    public static func connect() throws {
       try HampFirebaseManager.shared!.connect()
    }
}

extension Hamp {
    
    //MARK: Auth
    public struct Auth {
        
        /// Sing in user
        /// · Connect to firebase
        /// · If connection was successfull, get user from server
        ///
        /// - Parameters:
        ///   - mail: mail to connect
        ///   - password: password
        ///   - onSuccess: called if all was successfull
        ///   - onError: called if an error occurred
        public static func signIn(mail: String,
                                  password: String,
                                  onSuccess: ServerSuccess<HampUser>,
                                  onError: ServerError) {
            HampFirebaseAuth.signIn(
                withEmail: mail,
                password: password,
                onSuccess: { (firebaseUser) in
                    HampAPIUser.get(by: firebaseUser.uid, onSuccess: { (response) in
                        let json = response.data?.json
                        HampUserDefaultsManager.store(object: json as AnyObject, key: Constants.UserDefaultsKeys.currentUser)
                        onSuccess?(response)
                    }, onError: onError)
            },  onError: onError)
        }
        
        /// Get logged user
        ///
        /// - Returns: User logged, nil otherwise
        public static func user() -> HampUser? {
            let data = (HampUserDefaultsManager.retrieve(by: Constants.UserDefaultsKeys.currentUser) as! String).data(using: .utf8)
            let user = try? HampJSONManager.sharedDecoder.decode(HampUser.self, from: data!)
            return user
        }
        
        /// Sign up a new user
        /// · Connect to firebase
        /// · If connection was successfull, get user from server
        ///
        /// - Parameters:
        ///   - user: user to register
        ///   - password: password for user
        ///   - onSuccess: called if all was successfull
        ///   - onError: called if an error occurred on firebase register or creating user on database
        public static func signUp(with user: HampUser,
                                  password: String,
                                  onSuccess: ServerSuccess<HampUser>,
                                  onError: ServerError) {
            HampFirebaseAuth.createUser(withEmail: user.mail, password: password, onSuccess: { (firebaseUser) in
                var userWithID = user
                userWithID.identifier = firebaseUser.uid
                self.createUser(with: userWithID, onSuccess: onSuccess, onError: onError)
            }, onError:onError)
        }
        
        /// Login firebase with Facebook credentials
        ///
        /// - Parameters:
        ///   - accessToken:facebook access token
        ///   - user: user to store on database
        ///   - onSuccess: called if all was successfull
        ///   - onError: called if an error occurred on firebase register or creating user on database
        public static func facebookLogIn(with accessToken: String,
                                         user: HampUser,
                                         onSuccess: ServerSuccess<HampUser>,
                                         onError: ServerError) {
            HampFirebaseAuth.singInWithFacebook(accessToken: accessToken, onSuccess: { (firebaseUser) in
                HampAPIUser.get(by: firebaseUser.uid, onSuccess: { (response) in
                    onSuccess?(response)
                }, onError: { (error) in
                    if let e = error as? HampServerManager.ServerResponseError, e == .notFound {
                        var userWithID = user
                        userWithID.identifier = firebaseUser.uid
                        self.createUser(with: userWithID, onSuccess: onSuccess, onError: onError)
                    } else {
                        onError?(error)
                    }
                })
            }, onError: onError)
        }
    }
}

private extension Hamp.Auth {
    /// Create a new user on database
    ///
    /// - Parameters:
    ///   - user: user to create
    ///   - onSuccess: called if all was successfully
    ///   - onError: called if an error occurred
    static func createUser(with user: HampUser,
                    onSuccess: ServerSuccess<HampUser>,
                    onError: ServerError) {
        HampAPIUser.create(object: user, onSuccess:{ (response) in
            let json = response.data?.json
            HampUserDefaultsManager.store(object: json as AnyObject, key: Constants.UserDefaultsKeys.currentUser)
            onSuccess?(response)
        }, onError: onError)
    }
}
