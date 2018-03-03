//
//  Response.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

enum HTTPCode: Int, Codable {
    case ok = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalError = 500
    case unknown = -1
    
    init(code: Int) {
        self = HTTPCode(rawValue: code) ?? .unknown
    }
    
}

public class Response<T>: HampCodable where T: Codable {
    var code: HTTPCode
    var message: String
    var data: T? = nil
    
    init() {
        code = .badRequest
        message = ""
    }
    
    init(code: HTTPCode, message: String = "", data: T? = nil) {
        self.code = code
        self.message = message
        self.data = data
    }
}
