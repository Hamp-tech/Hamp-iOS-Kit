//
//  HMPFirebaseManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public struct HMPFirebaseManager {
    // MARK: Class properties
    
    /// Singleton with a default configuration:
    public static var sharedManager = try? HMPFirebaseManager(environtment : HMPFirebaseFilesProvider.defaultEnvirontment())
    
    // MARK: Properties
    public private(set) var environtment : HampEnvironment
    public private(set) var configured : Bool
    
    // MARK: Constructor
    init(environtment : HampEnvironment) {
        self.environtment = environtment
        self.configured = false
    }
    
    // MARK: Public API

    /// Connect to firebase
    public mutating func connect() {
        let options = FirebaseOptions.init(contentsOfFile: environtment.file.route)
        FirebaseApp.configure(options: options!)
        configured = true
    }
}
