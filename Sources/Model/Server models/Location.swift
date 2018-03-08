//
//  Location.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/3/18.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

public class Location: HampCodable {
	public var name: String?
	public var latitude: Double?
	public var longitude: Double?
    
    public init (name: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
