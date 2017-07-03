//
//  HMPFirebaseFilesProvider.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HMPFirebaseFilesProvider {
    /// Returns a "production" environment getting the default firebase plist name
    ///
    ///
    /// - Returns: Environment with a default firebase plist name
    /// - Throws: File missing
    public static func defaultEnvirontment() throws -> HMPEnvironment {
        let file = try? HMPFile(filename: "GoogleService-Info", ofType: "plist")
        return HMPEnvironment(name: "Production", file: file!)
        
    }
}
