//
//  HampServerManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 11/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Alamofire

public class HampServerManager {
    ///MARK: Typealias
    public typealias SuccessBlock<T : HampObject> = ((HampHTTPResponse<T>) -> ())?
    public typealias ErrorBlock = (() -> ())?
    
    //MARK: Properties
    public private(set) var environtment : HampEnvironment
    
    //MARK: Constructor
    public init(environtment: HampEnvironment) {
        self.environtment = environtment
    }
}

extension HampServerManager {
    //MARK: Different environtments
    ///Singleton with a production configuration:
    public static let productionManager = try? HampServerManager(environtment : HampEnvirontmentsProvider.productionEnvirontment())
    
    /// Singleton with a development configuration
    public static let developmentManager = try? HampServerManager(environtment : HampEnvirontmentsProvider.developmentEnvirontment())
    
    fileprivate func request<T>(_ type : T.Type,
                                url: String,
                                method : HTTPMethod,
                                parameters : [String : Any],
                                onSuccess: SuccessBlock<T>,
                                onError: ErrorBlock) {
        var url = url
        url.append("?gangway=7B3nPECsrty0vuZi7J74kSMVmHKljxK")
        Alamofire
            .request(url,method: method, parameters: parameters, encoding: JSONEncoding.default)
            .response { (response) in
                if let _ = response.error {
                    //Throw http error
                }
                guard let d = response.data else { return }
                if let hampResponse = try? HampJSONManager.sharedDecoder.decode(HampHTTPResponse<T>.self, from: d) {
                    onSuccess?(hampResponse)
                }
        }
    }
}

extension HampServerManager {
    public func createUser(by user: HampUser,
                           onSuccess: SuccessBlock<HampUser>,
                           onError: ErrorBlock) {
        
        let urlString = environtment.apiURL + "/users"
        let par = user.propertiesDictionary()
    
        self.request(HampUser.self,
                     url: urlString,
                     method: .post,
                     parameters: par,
                     onSuccess: onSuccess,
                     onError: onError)
    }
}

