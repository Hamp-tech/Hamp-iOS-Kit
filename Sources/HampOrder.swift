//
//  HampOrder.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 10/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public struct HampOrder : HampObject {
    
    //MARK: Properties
    public var smallBag : UInt8
    public var bigBag : UInt8
    public var curtain : UInt8
    public var cushion : UInt8
    public var quilt : UInt8
    public var sofaCover : UInt8
    public var blanket : UInt8
    
    //TODO: Implement dynamic order
    /// Get the price of the order
    ///
    /// - Returns: price
    public func orderAmount() -> UInt8 {
        return 1
    }
}
