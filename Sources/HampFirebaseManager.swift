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
        
        let options = FirebaseOptions.init(contentsOfFile: environtment.file.route)
        FirebaseApp.configure(options: options!)
        configured = true
    }
}

extension HampFirebaseManager {
    //MARK: Different environtments
    ///Singleton with a production configuration:
    public static let productionManager = try? HampFirebaseManager(environtment : HampEnvirontmentsProvider.productionEnvirontment())
    
    /// Singleton with a development configuration
    public static let developmentManager = try? HampFirebaseManager(environtment : HampEnvirontmentsProvider.developmentEnvirontment())
}

extension HampFirebaseManager {
    public enum ManagerError : Swift.Error {
        case alreadyConfigured
    }
}
