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

extension Date {
    private static let locale = Locale(identifier: "en_US_POSIX")
    private static var formatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }
    
    public func iso8601() -> String {
        return Date.formatter.string(from: self)
    }
}
