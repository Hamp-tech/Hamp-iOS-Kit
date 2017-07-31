//
//  AppDelegate.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import UIKit
import FirebaseCommunity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Hamp.environtment = try! HampEnvirontmentsProvider.productionEnvirontment()
        try! Hamp.connect()
        
//        Hamp.Auth.signIn(mail: "test@test.com", password: "arcanine", onSuccess: { (response) in
//            print(Hamp.Auth.user())
//        }, onError: {(error) in
//
//        })
        let user = try? HampUser(identifier: "-KqKx9khWMDPJlqZkFca", name: "joannnnnnnnnnn", surname: "molinas", mail: "joan@molinas.com", phone: "666666666", birthday: "05/05/1994", gender: "M", tokenFCM: "123", language: "ca-ES", OS: "iOS", signupDate: "05/05/1994")
//        Hamp.Auth.signUp(with: user!, password: "arcanine", onSuccess: { (response) in
//
//        }, onError: {(error) in
//
//        })
        
        HampAPIUser.update(object: user!, onSuccess: nil, onError: nil)
        return true
    }
    
    
}

