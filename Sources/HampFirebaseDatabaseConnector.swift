//
//  HampFirebaseDatabaseConnector.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation
import FirebaseCommunity

public protocol DatabaseConnectorDelegate : class {
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didAddedNewObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didRemoveObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didChangedObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, didMovedObject object: T)
    func connector<T>(connector : HampFirebaseDatabaseConnector<T>, fireEventObject object: T)
}

public class HampFirebaseDatabaseConnector <T : HampDatabaseObject> {
    //MARK: Public Properties
    public weak var delegate : DatabaseConnectorDelegate?
    public private(set) var path : String
    public private(set) var observing = false
    
    //MARK: Private Properties
    private var databaseReference = Database.database().reference()
    private var addedhandle : DatabaseHandle?
    private var removedhandle : DatabaseHandle?
    private var changedhandle : DatabaseHandle?
    private var movedhandle : DatabaseHandle?
    private var valuehandle : DatabaseHandle?
    
    
    /// Create new databaseConnector
    public init() {
        self.path = T.tableName
    }
    
    /// Create a new databaseConnector
    ///
    /// - Parameter path: path to table
    fileprivate init(path : String) {
        self.path = path
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
            addedhandle = observeChildAdded()
        case .removed:
            removedhandle = observeChildRemove()
        case .changed:
            changedhandle = observeChildChanged()
        case .moved:
            movedhandle = observeChildMoved()
        case .value:
            valuehandle = observeValue()
        }
        
        observing = true
    }
    
    /// Observe a collection of events
    ///
    /// - Parameter types: collection of events
    public func observe(of
        types : [DatabaseEvent]) {
        types.forEach { type in observe(of: type) }
    }
    
    /// Get all objects of table with tableName
    ///
    /// - Parameters:
    ///   - type: Type of observer
    ///   - onSuccess: success block with all table objects
    public func observeSingleEvent(
        of type : DatabaseEvent,
        onSuccess : @escaping ([HampDatabaseObject]) -> ()) {
        
        databaseReference.child(path).observeSingleEvent(of: type.firebaseEvent()) { (snapshot) in
            var objects = [T]()
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let restDict = child.value as? [String: Any] else { continue }
                if  let object = try? T(identifier: child.key, properties: restDict) {
                    objects.append(object)
                }
            }
            
           onSuccess(objects)
        }
    }
    
    /// Remove an observer
    ///
    /// - Parameter type: observer type
    public func remove(
        of type : DatabaseEvent) {
        
        func resethandle(handle : inout DatabaseHandle?) {
            databaseReference.removeObserver(withHandle: handle!)
            handle = nil
            observing =
                addedhandle != nil
                || removedhandle != nil
                || changedhandle != nil
                || movedhandle != nil
                || valuehandle != nil
        }
        
        switch type {
        case .added where addedhandle != nil:
            resethandle(handle: &addedhandle)
        case .removed where removedhandle != nil:
            resethandle(handle: &removedhandle)
        case .changed where changedhandle != nil:
            resethandle(handle: &changedhandle)
        case .moved where movedhandle != nil:
            resethandle(handle: &movedhandle)
        case .value where valuehandle != nil:
            resethandle(handle: &valuehandle)
        default:
            break
        }
    }
}

extension HampFirebaseDatabaseConnector {
    //MARK: Create child
    public func child(childID : String) -> HampFirebaseDatabaseConnector {
        let childPath = "\(path)/\(childID)"
        return HampFirebaseDatabaseConnector<T>(path: childPath)
    }
}

private extension HampFirebaseDatabaseConnector {
    //MARK: Private API
    //https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift
    
    /// Observe child added events on firebase
    ///
    /// - Returns: database handle linked with child added event
    private func observeChildAdded() -> DatabaseHandle {
        return databaseReference.child(path).observe(DataEventType.childAdded) { (snapshot) in
            if let obj = try? T(identifier: snapshot.key, properties: (snapshot.value as? [String: Any])) {
                self.delegate?.connector(connector: self, didAddedNewObject: obj)
            }
        }
    }
    
    /// Observe child removed events on firebase
    ///
    /// - Returns: database handle linked with child removed event
    private func observeChildRemove() -> DatabaseHandle {
        return databaseReference.child(path).observe(DataEventType.childRemoved, with: { (snapshot) in
            if let obj = try? T(identifier: snapshot.key, properties: (snapshot.value as? [String: Any])) {
                self.delegate?.connector(connector: self, didRemoveObject: obj)
            }
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handle linked with child changed event
    private func observeChildChanged() -> DatabaseHandle {
        return databaseReference.child(path).observe(DataEventType.childChanged, with: { (snapshot) in
            if let obj = try? T(identifier: snapshot.key, properties: (snapshot.value as? [String: Any])) {
                self.delegate?.connector(connector: self, didChangedObject: obj)
            }
        })
    }
    
    /// Observe child changed events on firebase
    ///
    /// - Returns: database handle linked with child changed event
    private func observeChildMoved() -> DatabaseHandle {
        return databaseReference.child(path).observe(DataEventType.childMoved, with: { (snapshot) in
            if let obj = try? T(identifier: snapshot.key, properties: (snapshot.value as? [String: Any])) {
                self.delegate?.connector(connector: self, didMovedObject: obj)
            }
        })
    }
    
    /// Observe value events on firebase
    ///
    /// - Returns: database handle linked with child value event
    private func observeValue() -> DatabaseHandle {
        return databaseReference.child(path).observe(DataEventType.value, with: { (snapshot) in
            if let obj = try? T(identifier: snapshot.key, properties: (snapshot.value as? [String: Any])) {
                self.delegate?.connector(connector: self, fireEventObject: obj)
            }
        })
    }
}

