//
//  HMPFirebaseDatabaseConnector.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public protocol DatabaseConnectorDelegate {
    func connector(connector : HMPFirebaseDatabaseConnector, didAddedNewObject object: HMPFirebaseObject)
    func connector(connector : HMPFirebaseDatabaseConnector, didRemoveObject object: HMPFirebaseObject)
    func connector(connector : HMPFirebaseDatabaseConnector, didChangedObject object: HMPFirebaseObject)
    func connector(connector : HMPFirebaseDatabaseConnector, didMovedObject object: HMPFirebaseObject)
    func connector(connector : HMPFirebaseDatabaseConnector, fireEventObject object: HMPFirebaseObject)
}

public class HMPFirebaseDatabaseConnector {
    //MARK: Public Properties
    public var delegate : DatabaseConnectorDelegate?
    public private(set) var name : String
    public private(set) var connected = false
    
    //MARK: Private Properties
    private var databaseReference = Database.database().reference()
    private var addedHandler : DatabaseHandle?
    private var removedHandler : DatabaseHandle?
    private var changedHandler : DatabaseHandle?
    private var movedHandler : DatabaseHandle?
    private var valueHandler : DatabaseHandle?
    
    
    /// Create new databaseConnector
    ///
    /// - Parameter name: firebase table name
    public init(name : String) {
        self.name = name
    }
}

extension HMPFirebaseDatabaseConnector {
    //MARK: Public API
    
    /// Observe firebase events
    ///
    /// - Parameter type: event to observe
    public func observe(
        of type : Event) {
        switch type {
        case .added:
            addedHandler = observeChildAdded()
        case .removed:
            removedHandler = observeChildRemove()
        case .changed:
            changedHandler = observeChildChanged()
        case .moved:
            movedHandler = observeChildMoved()
        case .value:
            valueHandler = observeValue()
        }
    }
    
    public func observeSingleEvent(
        of type : Event,
        objects : ([HMPFirebaseObject]?) -> ()) {
        
        databaseReference.child(name).observeSingleEvent(of: type.firebaseEvent()) { (snapshot) in
            //TODO: Implement
        }
    }
    
    public func remove(
        of type : Event) {
        
        var handle : DatabaseHandle?
        switch type {
        case .added:
            handle = addedHandler
        case .removed:
            handle = removedHandler
        case .changed:
            handle = changedHandler
        case .moved:
            handle = movedHandler
        case .value:
            handle = valueHandler
        }
        
        if let h = handle { databaseReference.removeObserver(withHandle: h) }
    }
}

private extension HMPFirebaseDatabaseConnector {
    //MARK: Private API
    //https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift
    
    /// Observe child added events on firebase
    ///
    /// - Returns: database handler linked with child added event
    private func observeChildAdded() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childAdded) { (snapshot) in
//            let obj = HMPFirebaseDatabaseObject(identifier: snapshot.key)
//            self.delegate?.connector(connector: self, didAddedNewObject: obj)
        }
    }
    
    /// Observe child removed events on firebase
    ///
    /// - Returns: database handler linked with child removed event
    private func observeChildRemove() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childRemoved, with: { (snapshot) in
//            let obj = HMPFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didRemoveObject: obj)
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handler linked with child changed event
    private func observeChildChanged() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childChanged, with: { (snapshot) in
//            let obj = HMPFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didChangedObject: obj)
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handler linked with child changed event
    private func observeChildMoved() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childMoved, with: { (snapshot) in
//            let obj = HMPFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didMovedObject: obj)
        })
    }
    
    /// Observe value events on firebase
    ///
    /// - Returns: database handler linked with child value event
    private func observeValue() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childChanged, with: { (snapshot) in
//            let obj = HMPFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, fireEventObject: obj)
        })
    }
}

extension HMPFirebaseDatabaseConnector {
    public enum Event {
        case added
        case removed
        case changed
        case moved
        case value
        
        fileprivate func firebaseEvent() -> DataEventType {
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
}