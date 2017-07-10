//
//  HampEnvirontmentsProvider.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampEnvirontmentsProvider {
    /// Returns a "production" environment getting the default firebase plist name
    ///
    ///
    /// - Returns: Environment with a default firebase plist name
    /// - Throws: File missing
    public static func productionEnvirontment() throws -> HampEnvironment {
        let file = try HampFile(filename: Constants.productionFirebaseFileName, ofType: "plist")
        return HampEnvironment(name: "Production", file: file, apiURL: Constants.productionAPIURL)
    }
    
    public static func developmentEnvirontment() throws -> HampEnvironment {
        let file = try HampFile(filename: Constants.developmentFirebaseFileName, ofType: "plist")
        return HampEnvironment(name: "Development", file: file, apiURL: Constants.developmentAPIURL)
    }
}
