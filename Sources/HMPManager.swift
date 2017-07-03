//
//  HMPManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public struct HMPManager {
    //MARK - Class properties
    /// Singleton with a default configuration:
    public static let sharedManager = try? HMPManager(environtment : HMPFirebaseFilesProvider.defaultEnvirontment())
    
    //MARK - Properties
    public private(set) var environtment : HMPEnvironment
    
    init(environtment : HMPEnvironment) {
        self.environtment = environtment
    }
}
