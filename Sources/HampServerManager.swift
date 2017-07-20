//
//  HampServerManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 11/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Alamofire

public typealias ServerSuccess<T : HampObject> = ((HampHTTPResponse<T>) -> ())?
public typealias ServerError = ((Error) -> ())?

internal class HampServerManager {
    //MARK: Properties
    public private(set) var environtment : HampEnvironment
    
    //MARK: Constructor
    public init(environtment: HampEnvironment) {
        self.environtment = environtment
    }
    
    /// Make request
    ///
    /// - Parameters:
    ///   - type: Expected server response object
    ///   - path: request path to add to base URL
    ///   - method: http method
    ///   - parameters: parameters to add to request
    ///   - onSuccess: called if request was successfully
    ///   - onError: called if an error occurred
    internal func request<T>(_ type : T.Type,
                                path: String,
                                method : HTTPMethod,
                                parameters : [String : Any]?,
                                onSuccess: ServerSuccess<T>,
                                onError: ServerError) {
        let url = environtment.apiURL + path + "?gangway=7B3nPECsrty0vuZi7J74kSMVmHKljxK"
        
        Alamofire
            .request(url,method: method, parameters: parameters, encoding: JSONEncoding.default)
            .response { (response) in
                if let _ = response.error {
                    onError?(ServerResponseError.unknown)
                    return
                }
                
                guard let d = response.data else { return }
                if let hampResponse = try? HampJSONManager.sharedDecoder.decode(HampHTTPResponse<T>.self, from: d) {
                    let error = ServerResponseError(rawValue: hampResponse.code)                    
                    error != nil ? onError?(error!) : onSuccess?(hampResponse)
                    
                }
        }
    }
}

extension HampServerManager {
    public enum ServerResponseError : UInt, CustomStringConvertible, Swift.Error {
        case noContent = 204
        case badRequest = 400
        case unauthorized = 401
        case notFound = 404
        case internalError = 500
        case unknown = 418 //teapot 8)
        
        /// Code number for each error
        public var code : UInt {
            return self.rawValue
        }
        
        public var description: String {
            switch self {
            case .noContent:
                return "Request and is not returning any content"
            case .badRequest:
                return "Invalid request parameters, ensure you're sending correct information"
            case .unauthorized:
                return "Unauthorized to request"
            case .notFound:
                return "Object to request not found"
            case .internalError:
                return "An error ocurred on server"
            case .unknown:
                return "Unknown error"
            }
        }
    }
}

extension HampServerManager {
    //MARK:
    /// Production environtment
    public static let productionEnvirontment = try! HampEnvirontmentsProvider.productionEnvirontment()
    
    /// Development environtment
    public static let developmentEnvirontment = try! HampEnvirontmentsProvider.developmentEnvirontment()
    
    /// Used by sharedManager
    /// Needs to be configured if external class uses sharedManager
    public static var defaultEnvirontment : HampEnvironment?
    
    /// Singleton used to access by external classes.
    /// Uses defaultEnvirontment to create singleton class
    public static let sharedManager = { () -> HampServerManager in
        precondition(HampServerManager.defaultEnvirontment != nil, "Assign default environtment first!")
        return HampServerManager(environtment: HampServerManager.defaultEnvirontment!)
    }()
}
