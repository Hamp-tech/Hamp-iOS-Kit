//
//  Regex.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 25/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

public struct Regex {
    
    //MARK: Properties
    private let regularExpression : NSRegularExpression
    private let pattern : String
    
    //MARK: Constructor
    public init(pattern : String) throws {
        self.pattern = pattern
        do {
            try regularExpression = NSRegularExpression(pattern: pattern)
        } catch let regexError as NSError {
            throw Error.wrongPattern(message: regexError.localizedDescription)
        } catch {
            throw Error.unknown
        }
    }
    
    //MARK: Public API
    /// Check if input string matches with pattern
    ///
    /// - Parameter input: string to match
    /// - Returns: if input matchs with pattern
    public func parse(input : String ) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Schemes.Regex.email).evaluate(with: input)
    }
}

extension Regex {
    enum Error : Swift.Error {
        case wrongPattern(message : String)
        case unknown
    }
}
