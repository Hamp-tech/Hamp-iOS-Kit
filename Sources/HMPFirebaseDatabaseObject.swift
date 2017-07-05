//
//  HMPDatabaseObject.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public class HMPFirebaseDatabaseObject : HMPFirebaseObject {
    public var identifier: String
    public var object: Any?
    
    required public init(identifier : String, object : Any?) {
        self.identifier = identifier
        self.object =  object
    }
    
}
