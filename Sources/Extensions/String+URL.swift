//
//  String+URL.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 15/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

extension String {
    var url: URL {
        let url = URL(string: self)
        assert(url != nil, "\(self) is not an url")
        
        return url!
    }
}
