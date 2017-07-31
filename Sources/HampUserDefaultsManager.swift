//
//  UserDefaultsManager.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 30/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

internal struct HampUserDefaultsManager {
    private static let userDefaults = UserDefaults.standard
    
    static func store(object: AnyObject?, key: String) {
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()
    }
    
    static func retrieve(by key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
    
    static func remove(by key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
}
