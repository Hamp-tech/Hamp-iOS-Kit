//
//  HampAPIBooking.swift
//  HampKit
//
//  Created by Joan Molinas Ramon on 18/7/17.
//  Copyright © 2017 com.hamp. All rights reserved.
//

import Foundation

public final class HampAPIBooking {
    
    ///Properties
    static let path = Constants.ServerPaths.booking
    
    /// Booking a new locker to user
    ///
    /// - Parameters:
    ///   - user: the user wants booking a locker
    ///   - card: card to pay
    ///   - order: order to booking
    ///   - onSuccess: called if booking was successfully
    ///   - onError: callef if an error occurred
    static func booking(user: HampUser,
                        card: HampCreditCard,
                        order: HampOrder,
                        onSuccess: ServerSuccess<HampBooking>,
                        onError: ServerError) {
        
        guard let uid = user.identifier else {
            preconditionFailure("User hasn't identifier")
        }
        
        guard let cid = card.identifier else {
            preconditionFailure("Card hasn't identifier")
        }
        
        let bookingPath = String(format: path, uid)
        
        let transaction = try? HampTransaction(identifier: nil, userID: nil, cardID: cid, order: order)
        let params = transaction?.propertiesDictionary()
        
        HampServerManager
            .shared!
            .request(HampBooking.self,
                     path: bookingPath,
                     method: .post,
                     parameters: params,
                     onSuccess: onSuccess,
                     onError: onError)
        
    }
    
}
