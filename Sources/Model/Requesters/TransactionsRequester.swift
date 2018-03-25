//
//  TransactionsRequester.swift
//  HampiOSKit
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import Foundation

internal struct TransactionsRequester: Requestable {
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func createTransaction(transaction: Transaction,
                           onResponse: @escaping onResponse<Transaction>) {
		let request = URLRequest.POST(Schemes.Transaction.createTransaction.replace(["{pid}": transaction.userID!]).url, body: transaction.toData!)
		
		session.dataTask(with: request) { (data, _, error) in
			guard let d = data else {
				onResponse(Response<Transaction>(code: .internalError, message: error!.localizedDescription))
				return
			}
			
			let resp = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: d)
			onResponse(resp)
		}.resume()
    }
	
	func transaction(userID: String,
					 transactionID: String,
					 onResponse: @escaping onResponse<Transaction>) {
		let request = URLRequest.GET(Schemes.Transaction.transaction.replace(["{pid}": userID, "{tid}": transactionID]).url)
		
		session.dataTask(with: request) { (data, _, error) in
			guard let d = data else {
				onResponse(Response<Transaction>(code: .internalError, message: error!.localizedDescription))
				return
			}
			
			onResponse(try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: d))
			}.resume()
	}
	
	func userTransactions(userID: String,
						  onResponse: @escaping onResponse<[Transaction]>) {
		let request = URLRequest.GET(Schemes.Transaction.userTransactions.replace(["{pid}": userID]).url)
		
		session.dataTask(with: request) { (data, _, error) in
			guard let d = data else {
				onResponse(Response<[Transaction]>(code: .internalError, message: error!.localizedDescription))
				return
			}
			
			onResponse(try! Singletons.sharedJSONDecoder.decode(Response<[Transaction]>.self, from: d))
		}.resume()
	}
	
	func deliver(transactionID: String,
				 userID: String,
				 onResponse: @escaping onResponse<Transaction>) {
		let request = URLRequest.POST(Schemes.Transaction.deliver.replace(["{pid}": userID, "{tid}": transactionID]).url)
		
		session.dataTask(with: request) { (data, _, error) in
			guard let d = data else {
				onResponse(Response<Transaction>(code: .internalError, message: error!.localizedDescription))
				return
			}
			
			onResponse(try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: d))
		}.resume()
	}
}
