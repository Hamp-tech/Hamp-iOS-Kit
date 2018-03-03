//
//  BookingError.swift
//  HampKit
//
//  Created by Aleix Baggerman on 28/02/2018.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

public enum BookingError: Error {
    case missingParameter (String)
}

extension BookingError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .missingParameter(let parameter):
            return "Missing parameter \(parameter)"
        }
    }
}
