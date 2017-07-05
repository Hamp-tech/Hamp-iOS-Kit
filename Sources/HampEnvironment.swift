//
//  HMPEnvirontment.swift
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
    
    
    // MARK: Constructor
    
    /// Create a new environtment
    ///
    /// - Parameters:
    ///   - name: environtment name
    ///   - file: firebase file path
    public init(name : String, file : HampFile) {
        self.name = name
        self.file = file
    }
}

extension HampEnvironment : Equatable {
    public static func ==(lhs: HampEnvironment, rhs: HampEnvironment) -> Bool {
        return lhs.name == rhs.name && lhs.file == rhs.file
    }
}














