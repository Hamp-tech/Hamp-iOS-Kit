//
//  String+Replace.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

extension String {
    func replace(_ replacements: [String: String]) -> String {
        var s = self
        replacements.forEach {
            s = s.replacingOccurrences(of: $0.key, with: $0.value)
        }
        
        return s
    }
}
