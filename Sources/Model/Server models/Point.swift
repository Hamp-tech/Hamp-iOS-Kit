//
//  Point.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/3/18.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

public class Point: Objectable {
	
	public var identifier: String?
	public var location: Location?
	public var CP: String?
	public var address: String?
	public var city: String?
//	var lockers: Array<HampyLocker>?
	
	public init(identifier: String? = nil,
		 location: Location? = nil,
		 CP: String? = nil,
		 address: String? = nil,
		 city: String? = nil
//		 lockers: Array<HampyLocker>?
		) {
		self.identifier = identifier
		self.location = location
		self.CP = CP
		self.address = address
		self.city = city
//		self.lockers = lockers

	}
	
	public func validate() throws { }
}
