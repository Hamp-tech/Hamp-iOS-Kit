//
//  HampFirebaseManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 3/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import FirebaseCommunity

public class HampFirebaseManager {
    //MARK: Properties
    public private(set) var environtment : HampEnvironment
    public private(set) var configured : Bool
    
    //MARK: Constructor
    init(environtment : HampEnvironment) {
        self.environtment = environtment
        self.configured = false
    }
    
    // MARK: Public API
    /// Connect to firebase
    public func connect() throws {
        if let _ = FirebaseApp.app() {
            throw ManagerError.alreadyConfigured
        }
    
        let options = FirebaseOptions(contentsOfFile: environtment.file.route)
        FirebaseApp.configure(options: options!)
        configured = true
    }
}

extension HampFirebaseManager {
    
    //MARK: Error
    public enum ManagerError : Swift.Error {
        case alreadyConfigured
    }
}

extension HampFirebaseManager {
    
    /// Environtment to connect
    public static var environtment: HampEnvironment = try! HampEnvirontmentsProvider.productionEnvirontment() {
        didSet {
            shared = HampFirebaseManager.init(environtment: environtment)
        }
    }
    
    /// Shared instance of server manager
    public static private(set) var shared: HampFirebaseManager?
}
