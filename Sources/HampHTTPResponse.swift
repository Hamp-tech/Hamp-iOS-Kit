//
//  HampHTTPResponse.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 11/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public class HampHTTPResponse<T : HampObject> : Codable {
    
    //MARK: Properties
    public private(set) var code: UInt = 0
    public private(set) var message: String?
    public private(set) var data: T?
}
