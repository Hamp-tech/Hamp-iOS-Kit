//
//  HampFirebaseDatabaseConnector.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import Firebase

public protocol DatabaseConnectorDelegate : class {
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didAddedNewObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didRemoveObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didChangedObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didMovedObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, fireEventObject object: T)
}

public class HampFirebaseDatabaseConnector <T : HampFirebaseObject> {
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

extension HampFirebaseDatabaseConnector {
    //MARK: Public API
    
    /// Observe firebase events
    ///
    /// - Parameter type: event to observe
    public func observe(
        of type : DatabaseEvent) {
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
        of type : DatabaseEvent,
        objects : ([HampFirebaseObject]?) -> ()) {
        
        databaseReference.child(name).observeSingleEvent(of: type.firebaseEvent()) { (snapshot) in
            //TODO: Implement
        }
    }
    
    public func remove(
        of type : DatabaseEvent) {
        
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

private extension HampFirebaseDatabaseConnector {
    //MARK: Private API
    //https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift
    
    /// Observe child added events on firebase
    ///
    /// - Returns: database handler linked with child added event
    private func observeChildAdded() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childAdded) { (snapshot) in
//            let obj = HampFirebaseDatabaseObject(identifier: snapshot.key)
//            self.delegate?.connector(connector: self, didAddedNewObject: obj)
        }
    }
    
    /// Observe child removed events on firebase
    ///
    /// - Returns: database handler linked with child removed event
    private func observeChildRemove() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childRemoved, with: { (snapshot) in
//            let obj = HampFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didRemoveObject: obj)
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handler linked with child changed event
    private func observeChildChanged() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childChanged, with: { (snapshot) in
//            let obj = HampFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didChangedObject: obj)
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handler linked with child changed event
    private func observeChildMoved() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childMoved, with: { (snapshot) in
//            let obj = HampFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, didMovedObject: obj)
        })
    }
    
    /// Observe value events on firebase
    ///
    /// - Returns: database handler linked with child value event
    private func observeValue() -> DatabaseHandle {
        return databaseReference.child(name).observe(DataEventType.childChanged, with: { (snapshot) in
//            let obj = HampFirebaseDatabaseObject(identifier: snapshot.key, object: snapshot.value)
//            self.delegate?.connector(connector: self, fireEventObject: obj)
        })
    }
}

