//
//  HMPFirebaseObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public protocol HMPFirebaseObject {
    var identifier : String { get }
    var object : Any? { get set }
    
    init(identifier : String, object : Any?) 
}
