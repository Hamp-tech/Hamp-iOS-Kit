//
//  HampCodableObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampObject: Codable {
    /// Check if dictionary contains required properties
    ///
    /// - Throws: Error if missing parameters
    func validate() throws
}

extension HampObject {
    /// Object as JSON Value
    var json : String {
        if let encoded = try? HampJSONManager.sharedEncoder.encode(self) {
            if let json = String(data : encoded, encoding : .utf8) {
               return json
            }
        }
        
        return ""
    }
}

extension HampObject {
    
    /// Create a dictionary with all non nin properties and their values
    ///
    /// - Returns: dictionary with properties
    func propertiesDictionary() -> [String : Any] {
        let selfReflectabled = Mirror(reflecting: self)
        var dict = [String : Any]()
        for (name, value) in selfReflectabled.children {
            guard let name = name else { continue }
        
            let propertyReflectabled = Mirror(reflecting: value)
            if propertyReflectabled.displayStyle == .optional, propertyReflectabled.children.count > 0 {
                let v = Mirror.unwrap(obj: value)
                dict[name] = (v is HampObject) ? (v as! HampObject).propertiesDictionary() : v
            } else if propertyReflectabled.displayStyle != .optional { // avoid nil value
                dict[name] = value
            }
        }
        return dict
    }
}
