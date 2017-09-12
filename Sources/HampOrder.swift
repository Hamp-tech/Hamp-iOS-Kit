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
    
    /// Description of services hired
    ///
    /// - Returns: Array with of services hired
    public func servicesHired() -> Array<String> {
        var arr = Array<String>.init()
        
        if smallBag > 0 { arr.append("Small bag") }
        if bigBag > 0 { arr.append("Big bag") }
        if curtain > 0 { arr.append("Curtain") }
        if cushion > 0 { arr.append("Cushion") }
        if quilt > 0 { arr.append("Quilt") }
        if sofaCover > 0 { arr.append("Sofa cover") }
        if blanket > 0 { arr.append("Blanket") }
        
        return arr
    }
    
    /// Number of services hired
    ///
    /// - Returns: number of services hired
    public func numberOfServicesHired() -> Int {
        return servicesHired().count
    }
    
    //MARK: HampObject protocol
    public func validate() throws {}
}
