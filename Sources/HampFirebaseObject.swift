//
//  HampFirebaseObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampFirebaseObject {
    /// Properties
    var identifier : String { get }
    static var tableName : String { get }
    
    /// Abstract constructor to create a firebase object
    ///
    /// - Parameter identifier: object identifier
    init(identifier : String)
    
    /// Abstract constructor to create a firebase object
    ///
    /// - Parameters:
    ///   - identifier: object identifier
    ///   - properties: dictionary with object properties
    init(identifier : String, properties : Dictionary<String, Any>?)
}


