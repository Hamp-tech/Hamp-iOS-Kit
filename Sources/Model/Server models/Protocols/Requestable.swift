//
//  Requestable.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

protocol Requestable {
    var session: URLSession { get }
    init(session: URLSession)
}
