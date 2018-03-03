//
//  AuthRequester.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public struct AuthRequester: Requestable {
    // MARK: - Properties
    var session: URLSession
    
    // MARK: - Life cycle
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func singIn(email: String, password: String, onResponse: @escaping onResponse<User>) {
        let request = URLRequest.POST(
            Schemes.Auth.signIn.url,
            body: "{\"email\": \"\(email)\", \"password\": \"\(password)\"}".data(using: .utf8)
        )
        
        session.dataTask(with: request) { (data, _, error) in            
            guard let d = data else {
                onResponse(Response<User>(code: .internalError, message: error!.localizedDescription))
                return
            }
        
            let resp = try! Singletons.sharedJSONDecoder.decode(Response<User>.self, from: d)
            onResponse(resp)
          
        }.resume()
    }
    
    public func signUp(user: User, onResponse: @escaping onResponse<User>) {
       let request = URLRequest.POST(Schemes.Auth.signUp.url, body: user.json.data(using: .utf8))
        
        session.dataTask(with: request) { (data, _, error) in
            guard let d = data else {
                onResponse(Response<User>(code: .internalError, message: error!.localizedDescription))
                return
            }

            let resp = try! Singletons.sharedJSONDecoder.decode(Response<User>.self, from: d)
            onResponse(resp)
        }.resume()
    }
}
