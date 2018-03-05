//
//  Point.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 5/3/18.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

public class Point: Objectable {
	
	var identifier: String?
	var location: Location?
	var CP: String?
	var address: String?
	var city: String?
//	var lockers: Array<HampyLocker>?
	
	init(identifier: String? = nil,
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
	
	func validate() throws { }
}
