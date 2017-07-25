//
//  HampManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 25/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HampManager {
    
    /// Environtment to connect
    static var environtment: HampEnvironment { get set }
    
    /// Shared instance
    static var shared: Self? { get }
    
    /// Instance environtment
    var environtment: HampEnvironment { get }
    
    /// Create a new Manager to this environtment
    ///
    /// - Parameter environtment: environtment to the instance
    init (environtment: HampEnvironment)
    
    
    
    
}
