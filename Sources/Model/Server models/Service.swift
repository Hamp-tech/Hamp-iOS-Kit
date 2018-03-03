//
//  Service.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public class Service: Objectable {

    public var identifier: String?
    public var name: String?
    public var description: String?
    public var imageURL: String?
    public var price: Float?
    public var size: Size?
    public var active: Bool?
    public var created: String?

    public init(identifier: String?,
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
    
    public func validate() throws {}
}
