//
//  AppDelegate.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //        try? HampFirebaseManager.productionManager?.connect()
        
        HampServerManager.defaultEnvirontment = HampServerManager.productionEnvirontment
        
        usersRequests()
        creditCardRequests()
        bookingRequests()
        
        return true
    }
    
    func usersRequests() {
        //        let user = try! HampUser(identifier: "-KoqsaNb5E96Xnwv3hwo", name: "joannnn", surname: "molinas", mail: "joan@joan.com", phone: "666555777", birthday: "01/01/1990", gender: "M", tokenFCM: "123", language: "1", OS: "iOS", signupDate: Date().iso8601())
        
        //        HampAPIUser.create(object: user, onSuccess: { (response) in
        //            print(response.code)
        //            print(response.message)
        //            print(response.data)
        //        }, onError: {() in
        //
        //        })
        
        //        HampAPIUser.update(object: user, onSuccess: { (response) in
        //            print(response.code)
        //            print(response.message)
        //            print(response.data)
        //        }, onError: { () in
        //
        //        })
        
        //        HampAPIUser.unsubscribe(identifier: "-KoqsaNb5E96Xnwv3hwo", onSuccess: { (response) in
        //            print(response.code)
        //            print(response.message)
        //            print(response.data)
        //        }, onError: { () in
        //
        //        })
        
    }
    
    func creditCardRequests() {
//        let user = try! HampUser(identifier: "-KoqsaNb5E96Xnwv3hwo",
//                                 name: "joannn",
//                                 surname: "molinas",
//                                 mail: "joan@joan.com",
//                                 phone: "666555777")

//        let creditCard = try! HampCreditCard(identifier: "-KoyFpTtDmydIGyYxfNE",
//                                             number: "4111111111111111",
//                                             month: "12",
//                                             year: "21",
//                                             cvv: "887")

//        HampAPICreditCard.create(object: creditCard, parent: user, onSuccess: { (response) in
//
//        }, onError: { () in
//
//        })
//        
//        HampAPICreditCard.remove(object: creditCard, parent: user, onSuccess: { (response) in
//
//        }, onError: {() in
//
//        })
    }
    
    func bookingRequests() {
//        let user = try! HampUser(identifier: "-KoqsaNb5E96Xnwv3hwo",
//                                 name: "joannn",
//                                 surname: "molinas",
//                                 mail: "joan@joan.com",
//                                 phone: "666555777")
//
//        let creditCard = try! HampCreditCard(identifier: "-KoyFpTtDmydIGyYxfNE",
//                                             number: "4111111111111111",
//                                             month: "12",
//                                             year: "21",
//                                             cvv: "888")
//        let order = HampOrder(smallBag: 1)
//
//        HampAPIBooking.booking(user: user, card: creditCard, order: order, onSuccess: { (response) in
//
//        }, onError: { () in
//
//        })
    }
    
}

