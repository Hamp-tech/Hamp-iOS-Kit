//
//  HMPDatabaseEvent.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public enum DatabaseEvent {
    case added
    case removed
    case changed
    case moved
    case value
    
    public func firebaseEvent() -> DataEventType {
        var handler : DataEventType
        switch self {
        case .added:
            handler = .childAdded
        case .removed:
            handler = .childRemoved
        case .changed:
            handler = .childChanged
        case .moved:
            handler = .childMoved
        case .value:
            handler = .value
        }
        
        return handler
    }
}
