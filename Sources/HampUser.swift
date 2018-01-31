//
//  User.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

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
    public var password: String
    public var phone: String
    public var birthday: String?
    public var gender: String?
    public var signupDate: Date?
    public var tokenFCM: String?
    public var os: String?
    public var language: String?
    public var lastActivity: Date?
    public var unsubscribed: Bool?
    public var stripeID: String?
    
    //MARK: Constructors
    
    public init (identifier: String? = nil,
                 name: String,
                 surname: String,
                 mail: String,
                 password: String,
                 phone: String,
                 birthday: String? = nil,
                 gender: String? = nil,
                 signupDate: Date? = nil,
                 tokenFCM: String? = nil,
                 os: String? = nil,
                 language: String?,
                 lastActivity: Date? = nil,
                 unsubscribed: Bool? = nil,
                 stripeID: String? = nil) throws {
        self.identifier = identifier
        self.name = name
        self.surname = surname
        self.mail = mail
        self.password = password
        self.phone = phone
        self.birthday = birthday
        self.gender = gender
        self.signupDate = signupDate
        self.tokenFCM = tokenFCM
        self.os = os
        self.language = language
        self.lastActivity = lastActivity
        self.unsubscribed = unsubscribed
        self.stripeID = stripeID
        
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
            try self.init(identifier: identifier,
                      name: properties?[Constants.User.name] as! String,
                      surname: properties?[Constants.User.surname] as! String,
                      mail: properties?[Constants.User.mail] as! String,
                      password: properties?[Constants.User.password] as! String,
                      phone: properties?[Constants.User.phone] as! String,
                      birthday: properties?[Constants.User.birthday] as? String,
                      gender: properties?[Constants.User.gender] as? String,
                      signupDate: properties?[Constants.User.signupDate] as? Date,
                      tokenFCM: properties?[Constants.User.tokenFCM] as? String,
                      os: properties?[Constants.User.os] as? String,
                      language: properties?[Constants.User.language] as? String,
                      lastActivity: properties?[Constants.User.lastActivity] as? Date,
                      unsubscribed: properties?[Constants.User.unsubscribed] as? Bool,
                      stripeID: properties?[Constants.User.stripeID] as? String)
    }
    
    public func validate() throws {}
}

extension HampUser {
    enum CodingKeys: String, CodingKey {
        case identifier = "firebaseID"
        case name
        case surname
        case mail
        case password
        case phone
        case birthday
        case gender
        case signupDate
        case tokenFCM
        case os
        case language
        case lastActivity
        case unsubscribed
        case stripeID
    }

}
