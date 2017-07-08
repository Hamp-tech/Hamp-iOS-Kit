//
//  Date+Utils.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

extension Date {
    private static func calendar() -> Calendar {
        return Calendar.current
    }
    
    public static func currentMonth() -> Int {
        return calendar().component(.month, from: Date()) as Int
    }
    
    public static func currentYear() -> Int {
        return calendar().component(.year, from: Date())
    }
}
