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
    
    public init(smallBag: UInt8 = 0,
                bigBag: UInt8 = 0,
                curtain: UInt8 = 0,
                cushion: UInt8 = 0,
                quilt: UInt8 = 0,
                sofaCover: UInt8 = 0,
                blanket: UInt8 = 0) {
        
        self.smallBag = smallBag
        self.bigBag = bigBag
        self.curtain = curtain
        self.cushion = cushion
        self.quilt = quilt
        self.sofaCover = sofaCover
        self.blanket = blanket
    }
    
    //TODO: Implement dynamic order
    /// Get the price of the order
    ///
    /// - Returns: price
    public func orderAmount() -> UInt8 {
        return 1
    }
}
