//
//  LogedUserHandler.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 9/3/18.
//  Copyright © 2018 com.hamp. All rights reserved.
//

import Foundation

struct LogedUserHandler {
	
	static func save(user: User?) {
		guard let u = user else { return }
		UserDefaults.standard.set(u.json, forKey: Schemes.UserDefaults.currentUser)
	}
	
	static func retrieve() -> User? {
		guard let u = UserDefaults.standard.string(forKey: Schemes.UserDefaults.currentUser) else { return nil}
		return try! Singletons.sharedJSONDecoder.decode(User.self, from: u.data(using: .utf8)!)
	}
}
