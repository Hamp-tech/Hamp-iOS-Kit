//
//  CreditCardError.swift
//  HampKit
//
//  Created by Aleix Baggerman on 27/02/2018.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

public enum CreditCardError: Error {
    case missingParameter(String), numberFormatError, invalidYear, invalidMonth, invalidCVV
}

extension CreditCardError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .missingParameter(let parameter):
                return "Missing parameter \(parameter)"
            case .numberFormatError:
                return "Invalid number"
            case .invalidYear:
                return "Invalid year"
            case .invalidMonth:
                return "Invalid month"
            case .invalidCVV:
                return "Invalid cvc"
        }
    }
}
