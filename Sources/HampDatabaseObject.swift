//
//  HampDatabaseObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampDatabaseObject : HampObject {
    /// Properties
    static var tableName : String { get }
    var identifier : String? { get }
    
    /// Abstract constructor to create a firebase object
    ///
    /// - Parameters:
    ///   - identifier: object identifier
    ///   - properties: dictionary with object properties
    /// - Throws: Error if identifier is empty or missing properties
    init(identifier : String?, properties : Dictionary<String, Any>?) throws 
}

public enum HampFirebaseObjectError : Swift.Error {
    case missingProperties
}



