//
//  Request.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

extension URLRequest {
	static func GET(_ url: URL,
					 contentType: String = "application/json") -> URLRequest {
		return run(url, httpMethod: .GET, contentType: contentType)
	}
	
    static func POST(_ url: URL,
                     body: Data? = nil,
                     contentType: String = "application/json") -> URLRequest {
        return run(url, body: body, httpMethod: .POST, contentType: contentType)
    }
    
    static func PUT(_ url: URL,
                    body: Data? = nil,
                    contentType: String = "application/json") -> URLRequest
    {
        return run(url, body: body, httpMethod: .PUT, contentType: contentType)
    }
    
    static func DELETE(_ url: URL,
                       body: Data? = nil,
                       contentType: String = "application/json") -> URLRequest {
        return run(url, body: body, httpMethod: .DELETE, contentType: contentType)
    }
    
    private static func run(_ url: URL,
                            body: Data? = nil,
                            httpMethod: RequestMethod,
                            contentType: String = "application/json") -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        return request
    }
}

