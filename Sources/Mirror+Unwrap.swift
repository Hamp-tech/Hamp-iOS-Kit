//
//  Mirror+Unwrap.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 11/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

extension Mirror {
    /// Unwrap mirror object
    ///
    /// - Parameter obj: object to unwrap
    /// - Returns: unwrapped object
    public static func unwrap(obj: Any) -> Any {
        let reflected = Mirror(reflecting: obj)
        guard reflected.displayStyle == .optional else { return obj }
        guard reflected.children.count > 0 else { return NSNull() }
        
        let (_, unwrapedObject) = reflected.children.first!
        return unwrapedObject
    }
}
