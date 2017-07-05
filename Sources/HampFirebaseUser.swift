//
//  HampFirebaseUser.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 4/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampFirebaseUser {
    //MARK: Properties
    var uid : String
    var email : String
}

extension HampFirebaseUser : Equatable {
    public static func ==(lhs: HampFirebaseUser, rhs: HampFirebaseUser) -> Bool {
        return lhs.uid == rhs.uid && lhs.email == rhs.email
    }
    
    
}
