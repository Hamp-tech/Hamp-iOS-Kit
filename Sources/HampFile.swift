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
        self.filepath = Bundle.main.bundlePath
        
        
        let podBundle = Bundle(for: type(of: self))
        
        if let bundleURL = podBundle.url(forResource: "HampKit", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                print(bundle)
            } else {
                print("bundle error")
            }
        } else {
            print("bundle url error")
        }
        
        guard let path = Bundle.main.path(forResource: filename, ofType: ofType) else {
            throw FileError.missingFileError
        }
        
        self.route = path
        
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

