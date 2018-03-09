//
//  UserRequester.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 17/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

internal struct UserRequester: Requestable {
    // MARK: - Properties
    var session: URLSession
    
    // MARK: - Life cycle
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func update(user: User, onResponse: @escaping onResponse<User>) {
        let urlRequest = URLRequest.PUT(Schemes.User.update.replace(["{pid}": user.identifier!]).url, body: user.json.data(using: .utf8))
        session.dataTask(with: urlRequest) { (data, _, error) in
            guard let d = data else {
                onResponse(Response<User>(code: .internalError, message: error!.localizedDescription))
                return
            }
            
            let resp = try! Singletons.sharedJSONDecoder.decode(Response<User>.self, from: d)
			LogedUserHandler.save(user: user)
            onResponse(resp)
        }.resume()
    }
    
    func createCreditCard(userIdentifier: String, card: CreditCard, onResponse: @escaping onResponse<CreditCard>) {
        let urlRequest = URLRequest.POST(Schemes.User.createCreditCard.replace(["{pid}": userIdentifier]).url, body: card.toData)
        session.dataTask(with: urlRequest) { (data, _, error) in
            guard let d = data else {
                onResponse(Response<CreditCard>(code: .internalError, message: error!.localizedDescription))
                return
            }
			
			let user = LogedUserHandler.retrieve()
			user?.cards?.append(card)
			LogedUserHandler.save(user: user)
			
            let resp = try! Singletons.sharedJSONDecoder.decode(Response<CreditCard>.self, from: d)
            onResponse(resp)
        }.resume()
    }
    
    func deleteCreditCard(userIdentifier: String, cardIdentifier: String, onResponse: @escaping onResponse<String>) {
        let urlRequest = URLRequest.DELETE(Schemes.User.removeCreditCard.replace(["{pid}": userIdentifier, "{cid}": cardIdentifier]).url)
        session.dataTask(with: urlRequest) { (data, _, error) in
            guard let d = data else {
                onResponse(Response<String>(code: .internalError, message: "Card removed successfully"))
                return
            }
            
            let resp = try! Singletons.sharedJSONDecoder.decode(Response<String>.self, from: d)
			if let u = LogedUserHandler.retrieve(), var cards = u.cards, let idx = cards.index(where: { (card) -> Bool in
				return card.identifier! == cardIdentifier
			}) {
				cards.remove(at: idx)
				LogedUserHandler.save(user: u)
			}
            onResponse(resp)
        }.resume()
		

    }
}
