//
//  HampTransaction.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampTransaction : HampDatabaseObject {
    
    //MARK: Class properties
    public static var tableName: String = Constants.FirebaseTableNames.transactions
    
    //MARK: Properties
    public var identifier: String?
    public var userID: String?
    public var cardID : String?
    public var order : HampOrder?
    
    
    //MARK: Constructor
    public init(identifier: String? = nil,
                userID: String?,
                cardID: String?,
                order: HampOrder?) throws {
        self.identifier = identifier
        self.userID = userID
        self.cardID = cardID
        self.order = order
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
     try self.init(identifier: identifier,
                   userID : properties?[Constants.Transaction.userID] as? String,
                   cardID: properties?[Constants.Transaction.cardID] as? String,
                   order: properties?[Constants.Transaction.order] as? HampOrder)
    }
    
    //MARK: HampObject protocol
    public func validate() throws {
        guard
            let u = userID,
            let c = cardID,
            let _ = order,
            u.count > 0,
            c.count > 0 else {
                throw HampFirebaseObjectError.missingProperties
                
        }
    }
}
