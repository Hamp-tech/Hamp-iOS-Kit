//
//  HampEnvirontment.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public class HampEnvironment {
    
    // MARK: Properties
    public private(set) var name : String
    public private(set) var file : HampFile
    public private(set) var apiURL : String
    
    
    // MARK: Constructor
    
    /// Create a new environtment
    ///
    /// - Parameters:
    ///   - name: environtment name
    ///   - file: firebase file path
    public init(name: String, file: HampFile, apiURL: String) {
        self.name = name
        self.file = file
        self.apiURL = apiURL
    }
}

extension HampEnvironment : Equatable {
    public static func ==(lhs: HampEnvironment, rhs: HampEnvironment) -> Bool {
        return lhs.name == rhs.name && lhs.file == rhs.file && lhs.apiURL == rhs.apiURL
    }
}














