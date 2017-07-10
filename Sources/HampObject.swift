//
//  HampCodableObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampObject : Codable {
    /// Check if dictionary contains required properties
    ///
    /// - Throws: Error if missing parameters
    func validate() throws
}

extension HampObject {
    var json : String {
        if let encoded = try? HampJSONManager.sharedEncoder.encode(self) {
            if let json = String(data : encoded, encoding : .utf8) {
               return json
            }
        }
        
        return ""
    }
}
