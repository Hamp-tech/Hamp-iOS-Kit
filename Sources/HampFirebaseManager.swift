//
//  HampFirebaseManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import FirebaseCommunity

internal final class HampFirebaseManager: HampManager {
    //MARK: Properties
    public static var environtment: HampEnvironment = try! HampEnvirontmentsProvider.productionEnvirontment() {
        didSet { shared = HampFirebaseManager.init(environtment: environtment) }
    }
    public static private(set) var shared: HampFirebaseManager?
    public private(set) var environtment : HampEnvironment
    public private(set) var configured : Bool
    
    //MARK: Constructor
    public required init(environtment : HampEnvironment) {
        self.environtment = environtment
        self.configured = false
    }
    
    // MARK: Public API
    /// Connect to firebase
    public func connect() throws {
        if configured, let _ = FirebaseApp.app() {
            throw ManagerError.alreadyConfigured
        }
        let options = FirebaseOptions(contentsOfFile: self.environtment.file.route)
        FirebaseApp.configure(options: options!)
//        FirebaseApp.configure()
        self.configured = true
        
        
    }
}

extension HampFirebaseManager {
    
    //MARK: Error
    public enum ManagerError : Swift.Error {
        case alreadyConfigured
    }
}

