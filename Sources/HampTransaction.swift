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
    public var date: String?
    public var payment: Double?
    
    
    //MARK: Constructor
    public init(identifier: String? = nil,
                userID: String?,
                cardID: String?,
                order: HampOrder?,
                date: String?,
                payment: Double?) throws {
        self.identifier = identifier
        self.userID = userID
        self.cardID = cardID
        self.order = order
        self.date = date
        self.payment = payment
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
     try self.init(identifier: identifier,
                   userID : properties?[Constants.Transaction.userID] as? String,
                   cardID: properties?[Constants.Transaction.cardID] as? String,
                   order: properties?[Constants.Transaction.order] as? HampOrder,
                   date: properties?[Constants.Transaction.date] as? String,
                   payment: properties?[Constants.Transaction.payment] as? Double)
    }
    
    //MARK: HampObject protocol
    public func validate() throws {
        guard
            let c = cardID,
            let _ = order,
            c.count > 0 else {
                throw HampFirebaseObjectError.missingProperties
                
        }
    }
}
