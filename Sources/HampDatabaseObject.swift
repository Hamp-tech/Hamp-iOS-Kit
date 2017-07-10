//
//  HampDatabaseObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampDatabaseObject : Codable {
    /// Properties
    var identifier : String? { get }
    static var tableName : String { get }
    
    /// Abstract constructor to create a firebase object
    ///
    /// - Parameters:
    ///   - identifier: object identifier
    ///   - properties: dictionary with object properties
    /// - Throws: Error if identifier is empty or missing properties
    init(identifier : String?, properties : Dictionary<String, Any>?) throws 
    
    /// Check if dictionary contains required properties
    ///
    /// - Throws: Error if missing parameters
    func checkParameterProperties() throws
}

public enum HampFirebaseObjectError : Swift.Error {
    case missingProperties
}



