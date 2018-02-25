//
//  Objectable.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

protocol Objectable: HampCodable {
    
    var identifier: String? { get set }
    
    func validate() throws
}
