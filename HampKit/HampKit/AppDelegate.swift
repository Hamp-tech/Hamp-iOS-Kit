//
//  AppDelegate.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DatabaseConnectorDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        try? HampFirebaseManager.sharedManager?.connect()
        HampFirebaseAuth.signIn(withEmail: "test@test.com", password: "arcanine")
        let order = try! HampLocker(identifier: "123", booked: false, lockerID: "123", secretKey: "123")
        print(order.json)
        
        return true
    }
    
    func connector<T>(connector: HampFirebaseDatabaseConnector<T>, didAddedNewObject object: T)  {
        print(object)
    }
    
    func connector<T>(connector: HampFirebaseDatabaseConnector<T>, didRemoveObject object: T)  {
        print(object)
    }
    
    func connector<T>(connector: HampFirebaseDatabaseConnector<T>, didChangedObject object: T) {
        print(object)
    }
    
    func connector<T>(connector: HampFirebaseDatabaseConnector<T>, didMovedObject object: T) {
        print(object)
    }
    
    func connector<T>(connector: HampFirebaseDatabaseConnector<T>, fireEventObject object: T) {
        print(object)
    }
    
    
}

