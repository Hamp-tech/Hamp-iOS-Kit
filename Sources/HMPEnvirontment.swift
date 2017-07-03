//
//  HMPEnvirontment.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public class HMPEnvironment {
    
    //MARK - Properties
    public private(set) var name : String
    public private(set) var file : HMPFile
    
    /// Create a new environtment
    ///
    /// - Parameters:
    ///   - name: environtment name
    ///   - file: firebase file path
    public init(name : String, file : HMPFile) {
        self.name = name
        self.file = file
    }
}














