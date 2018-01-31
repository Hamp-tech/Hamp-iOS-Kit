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
    public var cardID : String?
    public var order : HampOrder?
    public var date: String?
    
    
    //MARK: Constructor
    public init(identifier: String? = nil,
                cardID: String?,
                order: HampOrder?,
                date: String?) throws {
        self.identifier = identifier
        self.cardID = cardID
        self.order = order
        self.date = date
        try validate()
    }
    
    public init(identifier: String?, properties: Dictionary<String, Any>?) throws {
     try self.init(identifier: identifier,
                   cardID: properties?[Constants.Transaction.cardID] as? String,
                   order: properties?[Constants.Transaction.order] as? HampOrder,
                   date: properties?[Constants.Transaction.date] as? String)
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
