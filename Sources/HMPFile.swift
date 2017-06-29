//
//  HMPFile.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public struct HMPFile {
    // - MARK : Public propertes
    public private(set) var filename : String
    public private(set) var filepath : String
    
    // - MARK: Initializers
    
    // TODO: Write description
    /// Description
    ///
    /// - Parameter filename: name of file
    public init(filename : String, ofType : String) throws{
        self.filename = filename + "." + ofType
        
        guard let path = Bundle.main.path(forResource: filename, ofType: ofType) else {
            throw FileError.missingFileError
        }
        
        self.filepath = path
    }
}

extension HMPFile {
    enum FileError : Swift.Error {
        case missingFileError
    }
}

