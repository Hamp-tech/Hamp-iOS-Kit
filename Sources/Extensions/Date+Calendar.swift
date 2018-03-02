//
//  Date+Calendar.swift
//  HampKit
//
//  Created by Aleix Baggerman on 28/02/2018.
//  Copyright © 2018 com.hamp. All rights reserved.
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
