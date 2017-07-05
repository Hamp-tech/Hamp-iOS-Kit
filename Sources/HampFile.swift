//
//  HampFile.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public struct HampFile {
    // MARK: Public propertes
    public private(set) var filename : String
    public private(set) var filepath : String
    public private(set) var route : String
    
    // MARK: Initializers
    /// Create a new file struct with the name and extension of the file
    ///
    /// - Parameter filename: name of file
    public init(filename : String, ofType : String) throws{
        self.filename = filename + "." + ofType
        self.filepath = Bundle.main.bundlePath
        
        guard let path = Bundle.main.path(forResource: filename, ofType: ofType) else {
            throw FileError.missingFileError
        }
        
        self.route = path
        
    }
}

extension HampFile {
    
    /// Errors indicating the different problems finding a file
    ///
    /// - missingFileError: file doesn't exists
    enum FileError : Swift.Error {
        case missingFileError
    }
}

extension HampFile : Equatable {
    public static func ==(lhs: HampFile, rhs: HampFile) -> Bool {
        return lhs.route == rhs.route
    }
}

