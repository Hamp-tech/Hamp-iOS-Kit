//
//  HampCodable.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

protocol HampCodable: Codable {
    var json: String { get }
    var dict: [String: Any] { get }
    var toData: Data? { get }
}

extension HampCodable {
    var json: String {
        return String(data: try! Singletons.sharedJSONEncoder.encode(self), encoding: .utf8) ?? ""
    }
    
    var dict: [String: Any] {
        var d = [String:Any]()
        for (key, value) in Mirror(reflecting: self).children where key != nil {
            if case Optional<Any>.some(_) = value {
                d[key!] = value as AnyObject
            }
        }
        
        return d
    }
    
    var toData: Data? {
        return self.json.data(using: .utf8) ?? "".data(using: .utf8)
    }
}


extension Array: HampCodable {
    
}
