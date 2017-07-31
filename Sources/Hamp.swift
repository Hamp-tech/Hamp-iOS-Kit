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
        
        /// <#Description#>
        ///
        /// - Returns: <#return value description#>
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
                HampAPIUser.create(object: user, onSuccess: { (response) in
                    let json = response.data?.json
                    HampUserDefaultsManager.store(object: json as AnyObject, key: Constants.UserDefaultsKeys.currentUser)
                    onSuccess?(response)
                }, onError: onError)
            }, onError:onError)
        }
    }
}
