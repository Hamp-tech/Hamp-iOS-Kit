//
//  Service.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

class Service: Objectable {

    var identifier: String?
    var name: String?
    var description: String?
    var imageURL: String?
    var price: Float?
    var size: Size?
    var active: Bool?
    var created: String?
    
    init(identifier: String?,
         name: String?,
         description: String?,
         imageURL: String?,
         price: Float?,
         size: Size?,
         active: Bool?,
         created: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.price = price
        self.size = size
        self.active = active
        self.created = created
    }
    
    func validate() throws {}
}
