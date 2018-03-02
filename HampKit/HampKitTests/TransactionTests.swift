//
//  TransactionTests.swift
//  HampiOSKitTests
//
//  Created by Joan Molinas Ramon on 23/2/18.
//  Copyright © 2018 Hamp. All rights reserved.
//

import XCTest
@testable import HampKit

class TransactionTests: XCTestCase {
	
	func testTransaction() {
		let raw = """
            {
                "creditCardIdentifier" : "card_1Byi0kCiVhDLJHAG1ASL3qlg",
                "booking": {
                    "basket": [
                        {
                            "service" : "1",
                            "amount" : 1
                        }
                    ],
                    "price": 13,
                    "point": "1",
                    "pickUpTime": "1"
                }
            }
        """
		
		let responseRaw = """
			{
				"message": "Services booked",
				"data": {
					"pickUpDate": "2018-02-23T17:53:15.816",
					"userID": "995828f80c7d4479a8caf3a90079d0e8",
					"identifier": "709940bf165e453cacd858392e09f726",
					"creditCardIdentifier": "card_1Byi0kCiVhDLJHAG1ASL3qlg",
					"booking": {
						"pickUpLockers": [
							{
								"code": "1112",
								"number": 2,
								"identifier": "2",
								"available": true,
								"capacity": "S"
							}
						],
						"pickUpTime": "1",
						"basket": [
							{
								"service": "1",
								"amount": 1
							}
						],
						"price": 13,
						"point": "1"
					}
				},
				"code": 200
			}
		"""
		
		let response = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: responseRaw.data(using: .utf8)!)
		
		let session = URLSessionMock(data: response.toData)
		
		let transaction = try! Singletons.sharedJSONDecoder.decode(Transaction.self, from: raw.data(using: .utf8)!)
		transaction.identifier = "995828f80c7d4479a8caf3a90079d0e8"
		
		let requester = TransactionsRequester(session: session)
		
		let createTransactionExpectation = expectation(description: "Create transaction expectation")
		
		requester.createTransaction(transaction: transaction) { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.message, "Services booked")
			XCTAssertNotNil(response.data?.pickUpDate)
			XCTAssertEqual(response.data?.userID, "995828f80c7d4479a8caf3a90079d0e8")
			XCTAssertEqual(response.data?.creditCardIdentifier, "card_1Byi0kCiVhDLJHAG1ASL3qlg")
			XCTAssertEqual(response.data?.booking?.pickUpTime, .afternoon)
			XCTAssertEqual(response.data?.booking?.price, 13.0)
			XCTAssertEqual(response.data?.booking?.point, "1")
			XCTAssertEqual(response.data?.booking?.pickUpLockers?.count, 1)
			XCTAssertEqual(response.data?.booking?.basket?.count, 1)
			createTransactionExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 10) { (error) in
			if let error = error {
				print(error)
			}
		}
	}
	
	func testCreateNoLockersAvailable() {
		func testTransaction() {
			let raw = """
            {
                "creditCardIdentifier" : "card_1Byi0kCiVhDLJHAG1ASL3qlg",
                "booking": {
                    "basket": [
                        {
                            "service" : "1",
                            "amount" : 1
                        }
                    ],
                    "price": 13,
                    "point": "1",
                    "pickUpTime": "1"
                }
            }
        """
			
			let responseRaw = """
			{
				"message": "Not enough lockers to satisfy your necessities",
				"code": 409
			}
			"""
			
			let response = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: responseRaw.data(using: .utf8)!)
			
			let session = URLSessionMock(data: response.toData)
			
			let transaction = try! Singletons.sharedJSONDecoder.decode(Transaction.self, from: raw.data(using: .utf8)!)
			transaction.identifier = "995828f80c7d4479a8caf3a90079d0e8"
			
			let requester = TransactionsRequester(session: session)
			
			let createTransactionExpectation = expectation(description: "Create transaction expectation")
			
			requester.createTransaction(transaction: transaction) { (response) in
				XCTAssertEqual(response.code, .conflict)
				XCTAssertEqual(response.message, "Not enough lockers to satisfy your necessities")
				XCTAssertNil(response.data)
				createTransactionExpectation.fulfill()
			}
			
			waitForExpectations(timeout: 10) { (error) in
				if let error = error {
					print(error)
				}
			}
		}
	}
	
	func testTransactionError() {
		let raw = """
            {
                "creditCardIdentifier" : "card_1Byi0kCiVhDLJHAG1ASL3qlg",
                "booking": {
                    "basket": [
                        {
                            "service" : "1",
                            "amount" : 1
                        }
                    ],
                    "price": 13,
                    "point": "1",
                    "pickUpTime": "1"
                }
            }
        """
		
		let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
		
		let session = URLSessionMock(error: error)
		
		let transaction = try! Singletons.sharedJSONDecoder.decode(Transaction.self, from: raw.data(using: .utf8)!)
		transaction.identifier = "995828f80c7d4479a8caf3a90079d0e8"
		
		let requester = TransactionsRequester(session: session)
		
		requester.createTransaction(transaction: transaction) { (response) in
			XCTAssertEqual(response.code, .internalError)
			
		}
	}
	
	func testUserTransactionsWithTransactions() {
		let responseRaw = """
			{
			"message": "",
			"data": [
				{
					"userID": "995828f80c7d4479a8caf3a90079d0e8",
					"creditCardIdentifier": "card_1Byi0kCiVhDLJHAG1ASL3qlg",
					"lastActivity": "2018-02-23T17:50:55.408",
					"booking": {
						"pickUpLockers": [
							{
								"code": "1111",
								"number": 1,
								"identifier": "1",
								"available": true,
								"capacity": "S"
							}
						],
						"pickUpTime": "1",
						"basket": [
							{
								"service": "1",
								"amount": 1
							}
						],
						"price": 13,
						"point": "1"
					},
					"created": "2018-02-23T17:50:55.408",
					"identifier": "874725e48029488ead4c9b28b08e100c",
					"pickUpDate": "2018-02-23T17:50:53.561"
				},
				{
					"userID": "995828f80c7d4479a8caf3a90079d0e8",
					"creditCardIdentifier": "card_1Byi0kCiVhDLJHAG1ASL3qlg",
					"lastActivity": "2018-02-23T17:53:17.656",
					"booking": {
						"pickUpLockers": [
							{
								"code": "1112",
								"number": 2,
								"identifier": "2",
								"available": true,
								"capacity": "S"
							}
						],
						"pickUpTime": "1",
						"basket": [
							{
								"service": "1",
								"amount": 1
							}
						],
						"price": 13,
						"point": "1"
					},
					"created": "2018-02-23T17:53:17.656",
					"identifier": "709940bf165e453cacd858392e09f726",
					"pickUpDate": "2018-02-23T17:53:15.816"
				}
			],
			"code": 200
		}
		"""
		
		let response = try! Singletons.sharedJSONDecoder.decode(Response<[Transaction]>.self, from: responseRaw.data(using: .utf8)!)
		let session = URLSessionMock(data: response.toData)
		
		let requester = TransactionsRequester(session: session)
		requester.userTransactions(userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.data?.count, 2)
			XCTAssertEqual(response.message, "")
		}
	}
	
	func testUserTransactionsWithoutTransactions() {
		let responseRaw = """
			{
				"message": "",
				"data": [],
				"code": 200
			}
			"""
		
		let response = try! Singletons.sharedJSONDecoder.decode(Response<[Transaction]>.self, from: responseRaw.data(using: .utf8)!)
		let session = URLSessionMock(data: response.toData)
		
		let requester = TransactionsRequester(session: session)
		requester.userTransactions(userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.data?.count, 0)
			XCTAssertEqual(response.message, "")
		}
	}
	
	func testUserTransactionsError() {
		
		let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
		let session = URLSessionMock(error: error)
		let requester = TransactionsRequester(session: session)
		
		requester.userTransactions(userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .internalError)
		}
	}
	
	func testDeliverTransaction() {
		let rawResponse = """
				{
					"message": "",
					"data": {
						"userID": "995828f80c7d4479a8caf3a90079d0e8",
						"creditCardIdentifier": "card_1Byi0kCiVhDLJHAG1ASL3qlg",
						"lastActivity": "2018-02-23T17:50:55.408",
						"booking": {
							"deliveryLockers": [
								{
									"code": "1111",
									"number": 1,
									"identifier": "1",
									"available": false,
									"capacity": "S"
								}
							],
							"pickUpLockers": [
								{
									"code": "1111",
									"number": 1,
									"identifier": "1",
									"available": true,
									"capacity": "S"
								}
							],
							"pickUpTime": "1",
							"basket": [
								{
									"service": "1",
									"amount": 1
								}
							],
							"price": 13,
							"point": "1"
						},
						"deliveryDate": "2018-02-24T17:17:15.984",
						"identifier": "874725e48029488ead4c9b28b08e100c",
						"created": "2018-02-23T17:50:55.408",
						"pickUpDate": "2018-02-23T17:50:53.561"
					},
					"code": 200
				}
			"""
		let response = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: rawResponse.data(using: .utf8)!)
		let session = URLSessionMock(data: response.toData)
		
		let requester = TransactionsRequester(session: session)
		
		requester.deliver(transactionID: "874725e48029488ead4c9b28b08e100c", userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.data?.identifier, "874725e48029488ead4c9b28b08e100c")
			XCTAssertEqual(response.data?.userID, "995828f80c7d4479a8caf3a90079d0e8")
			XCTAssertEqual(response.data?.booking?.deliveryLockers?.count, 1)
			XCTAssertNotNil(response.data?.deliveryDate)
		}
	}
	
	func testDeliverTransactionError() {
		
		let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
		let session = URLSessionMock(error: error)
		let requester = TransactionsRequester(session: session)
		
		requester.deliver(transactionID: "874725e48029488ead4c9b28b08e100c", userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .internalError)
		}
	}
}

