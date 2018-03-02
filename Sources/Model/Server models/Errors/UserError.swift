//
//  UserError.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 24/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

enum UserError: Error {
	/// Missing a parameter on user
	case missingParameter(String), emailFormatError, phoneFormatError
}

extension UserError: CustomStringConvertible {
	var description: String {
		switch self {
		case .missingParameter(let parameter):
			return "Missing parameter \(parameter)"
        case .emailFormatError:
            return "Email format error"
        case .phoneFormatError:
            return "Phone format error"
		}
	}
}
