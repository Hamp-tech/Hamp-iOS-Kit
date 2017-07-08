//
//  HampRegexParser.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 8/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampRegex {
    
    //MARK: Properties
    private let regularExpression : NSRegularExpression
    private let pattern : String
    
    //MARK: Constructor
    public init(pattern : String) throws {
        self.pattern = pattern
        do {
            try regularExpression = NSRegularExpression(pattern: pattern)
        } catch let regexError as NSError {
            throw RegexError.foo(message: regexError.localizedDescription)
        } catch {
            throw RegexError.unknown
        }
    }
    
    //MARK: Public API
    /// Check if input string matches with pattern
    ///
    /// - Parameter input: string to match
    /// - Returns: if input matchs with pattern
    public func parse(input : String ) -> Bool {
        let matches = regularExpression.matches(in: input, range: NSRange(input.startIndex..., in : input))
        return matches.count > 0
    }
}

extension HampRegex {
    enum RegexError : Swift.Error {
        case foo(message : String)
        case unknown
    }
}
