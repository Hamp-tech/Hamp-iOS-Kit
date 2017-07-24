//
//  HampFile.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import FirebaseCommunity.FirebaseAuth

public final class HampFile {
    // MARK: Public propertes
    public private(set) var filename : String
    public private(set) var filepath : String
    public private(set) var route : String
    
    /// Create a new file with the name and extension of the file
    ///
    /// - Parameters:
    ///   - filename: name of file
    ///   - ofType: extension of file
    /// - Throws: throws if file not exists
    public init(filename : String, ofType : String) throws{
        self.filename = filename + "." + ofType
    
        let bundle = Bundle(for: type(of: self))
        self.filepath = bundle.bundlePath
        self.route = ""
        
        if let bundleFilePath = bundle.url(forResource: filename, withExtension: ofType) {
            self.route = bundleFilePath.path
        } else {
            throw FileError.missingFileError
        }
    }
}

extension HampFile {
    /// Errors finding a file
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

