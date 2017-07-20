//
//  Date+Utils.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

extension Date {
    /// Get current Calendar
    ///
    /// - Returns: current calendar
    private static func calendar() -> Calendar {
        return Calendar.current
    }
    
    /// Get current date month
    ///
    /// - Returns: current month
    public static func currentMonth() -> Int {
        return calendar().component(.month, from: Date()) as Int
    }
    
    /// Get current year
    ///
    /// - Returns: current year
    public static func currentYear() -> Int {
        return calendar().component(.year, from: Date())
    }
}

extension Date {
    /// ISO8601 locale
    private static let locale = Locale(identifier: "en_US_POSIX")
    
    /// ISO8601 formatter
    private static var formatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }
    
    /// Get date string with ISO8601 format
    ///
    /// - Returns: date string
    public func iso8601() -> String {
        return Date.formatter.string(from: self)
    }
}
