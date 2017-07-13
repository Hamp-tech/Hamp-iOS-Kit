//
//  User.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

import Foundation

/// Set correct formats for:
/// - phone: +34 xxx xxx xxx
/// - mail: xx@xx.xx
/// - birthday: ISO8601
/// - gender: M, F or U
/// - language: iOS
/// - signupDate: ISO8601
public struct HampUser : HampDatabaseObject {
    
    //MARK: Class properties
    public static var tableName: String = Constants.FirebaseTableNames.users
    
    //MARK: Properties
    public var identifier: String?
    public var name: String
    public var surname: String
    public var mail: String
    public var phone: String
    public var birthday: String?
    public var gender: String?
    public var tokenFCM: String?
    public var language: String?
    public var os: String?
    public var signupDate: String?
    
    //MARK: Constructors
    public init(identifier: String? = nil,
                name: String,
                surname: String,
                mail: String,
                phone: String,
                birthday: String? = nil,
                gender: String? = nil,
                tokenFCM: String? = nil,
                language: String? = nil,
                OS: String? = nil,
                signupDate: String? = nil) throws {
        self.identifier = identifier
        self.name = name
        self.surname = surname
        self.mail = mail
        self.phone = phone
        self.birthday = birthday
        self.gender = gender
        self.tokenFCM = tokenFCM
        self.language = language
        self.os = OS
        self.signupDate = signupDate
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
        try self.init(identifier: identifier,
                      name: properties?[Constants.User.name] as! String,
                      surname: properties?[Constants.User.surname] as! String,
                      mail: properties?[Constants.User.mail] as! String,
                      phone: properties?[Constants.User.phone] as! String,
                      birthday: properties?[Constants.User.birthday] as? String,
                      gender: properties?[Constants.User.gender] as? String,
                      tokenFCM: properties?[Constants.User.tokenFCM] as? String,
                      language: properties?[Constants.User.language] as? String,
                      OS: properties?[Constants.User.OS] as? String,
                      signupDate: properties?[Constants.User.signupDate] as? String)
    }
    
    public func validate() throws {}
}

extension HampUser {
    enum CodingKeys: String, CodingKey {
        case identifier = "firebaseID"
        case name
        case surname
        case mail
        case phone
        case birthday
        case gender
        case tokenFCM
        case language
        case os
        case signupDate
    }

}
