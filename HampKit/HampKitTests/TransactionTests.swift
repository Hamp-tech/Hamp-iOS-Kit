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
        	"creditCard" : {
        		"id": "card_1C0CYpCiVhDLJHAGt2bsx9mW"
        	},
        	"booking": {
        		"basket": [
        			{
        				"service" : "1",
        				"amount" : 2
        			}
        		],
        		"price": 26,
        		"point": {
        			"identifier": "1"
        		},
        		"pickUpTime": "1"
        	}
        }
        """
		
		let responseRaw = """
			{
			"message": "Services booked",
			"data": {
				"creditCard": {
					"number": "4242",
					"exp_month": 12,
					"exp_year": 23
				},
				"userID": "126fb593b8374dfcb2225bd0d9779a12",
				"identifier": "b9ebe71c6bda4924a6f660c1c3d964e6",
				"pickUpDate": "2018-03-05T22:14:29.180",
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
							"amount": 2
						}
					],
					"price": 26,
					"point": {
						"city": "El Vendrell",
						"CP": "43700",
						"identifier": "1",
						"location": {
							"name": "1",
							"longitude": 0,
							"latitude": 0
						},
						"address": "C? foo bar 1"
					}
				}
			},
			"code": 200
		}
		"""
		
		let response = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: responseRaw.data(using: .utf8)!)
		
		let session = URLSessionMock(data: response.toData)
		
		let transaction = try! Singletons.sharedJSONDecoder.decode(Transaction.self, from: raw.data(using: .utf8)!)
		transaction.userID = "995828f80c7d4479a8caf3a90079d0e8"
		
		let requester = TransactionsRequester(session: session)
		
		let createTransactionExpectation = expectation(description: "Create transaction expectation")
		
		requester.createTransaction(transaction: transaction) { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.message, "Services booked")
			XCTAssertNotNil(response.data?.pickUpDate)
			XCTAssertEqual(response.data?.userID, "126fb593b8374dfcb2225bd0d9779a12")
			XCTAssertNil(response.data?.creditCard?.identifier)
			XCTAssertEqual(response.data?.booking?.pickUpTime, .afternoon)
			XCTAssertEqual(response.data?.booking?.price, 26.0)
			XCTAssertEqual(response.data?.booking?.point?.identifier, "1")
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
		let raw = """
            {
        	"creditCard" : {
        		"id": "card_1C0CYpCiVhDLJHAGt2bsx9mW"
        	},
        	"booking": {
        		"basket": [
        			{
        				"service" : "1",
        				"amount" : 2
        			}
        		],
        		"price": 26,
        		"point": {
        			"identifier": "1"
        		},
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
		transaction.userID = "995828f80c7d4479a8caf3a90079d0e8"
		
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
	
	func testTransactionError() {
		let raw = """
            {
        	"creditCard" : {
        		"id": "card_1C0CYpCiVhDLJHAGt2bsx9mW"
        	},
        	"booking": {
        		"basket": [
        			{
        				"service" : "1",
        				"amount" : 2
        			}
        		],
        		"price": 26,
        		"point": {
        			"identifier": "1"
        		},
        		"pickUpTime": "1"
        	}
        }
        """
		
		let error = NSError(domain: "", code: HTTPCode.internalError.rawValue, userInfo: nil)
		
		let session = URLSessionMock(error: error)
		
		let transaction = try! Singletons.sharedJSONDecoder.decode(Transaction.self, from: raw.data(using: .utf8)!)
		transaction.userID = "995828f80c7d4479a8caf3a90079d0e8"
		
		let requester = TransactionsRequester(session: session)
		
		requester.createTransaction(transaction: transaction) { (response) in
			XCTAssertEqual(response.code, .internalError)
			
		}
	}
	
	// TODO: Update to new model
	func testUserTransactionsWithTransactions() {
		let responseRaw = """
		{
			"message": "",
			"data": [
				{
					"userID": "126fb593b8374dfcb2225bd0d9779a12",
					"lastActivity": "2018-03-05T22:09:12.168",
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
								"amount": 2
							}
						],
						"price": 26,
						"point": {
							"city": "El Vendrell",
							"CP": "43700",
							"lockers": [
								{
									"code": "1111",
									"number": 1,
									"identifier": "1",
									"available": true,
									"capacity": "S"
								},
								{
									"code": "1112",
									"number": 2,
									"identifier": "2",
									"available": false,
									"capacity": "S"
								},
								{
									"code": "1113",
									"number": 3,
									"identifier": "3",
									"available": true,
									"capacity": "M"
								}
							],
							"identifier": "1",
							"location": {
								"name": "1",
								"longitude": 0,
								"latitude": 0
							},
							"address": "C? foo bar 1"
						}
					},
					"created": "2018-03-05T22:09:12.168",
					"creditCard": {
						"id": "card_1C0CYpCiVhDLJHAGt2bsx9mW",
						"number": "4242",
						"exp_year": 23,
						"exp_month": 12
					},
					"identifier": "94882df3a12f466f95d350addde48c72",
					"pickUpDate": "2018-03-05T22:09:09.793"
				},
			],
			"code": 200
		}
		"""
		
		let response = try! Singletons.sharedJSONDecoder.decode(Response<[Transaction]>.self, from: responseRaw.data(using: .utf8)!)
		let session = URLSessionMock(data: response.toData)
		
		let requester = TransactionsRequester(session: session)
		requester.userTransactions(userID: "995828f80c7d4479a8caf3a90079d0e8") { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.data?.count, 1)
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
					"userID": "126fb593b8374dfcb2225bd0d9779a12",
					"lastActivity": "2018-03-05T22:14:31.280",
					"booking": {
						"point": {
							"city": "El Vendrell",
							"CP": "43700",
							"lockers": [
								{
									"code": "1111",
									"number": 1,
									"identifier": "1",
									"available": true,
									"capacity": "S"
								},
								{
									"code": "1112",
									"number": 2,
									"identifier": "2",
									"available": false,
									"capacity": "S"
								},
								{
									"code": "1113",
									"number": 3,
									"identifier": "3",
									"available": true,
									"capacity": "M"
								}
							],
							"identifier": "1",
							"location": {
								"name": "1",
								"longitude": 0,
								"latitude": 0
							},
							"address": "C? foo bar 1"
						},
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
								"amount": 2
							}
						],
						"price": 26,
						"deliveryLockers": [
							{
								"code": "1111",
								"number": 1,
								"identifier": "1",
								"available": false,
								"capacity": "S"
							}
						]
					},
					"deliveryDate": "2018-03-05T22:44:37.176",
					"created": "2018-03-05T22:14:31.280",
					"identifier": "b9ebe71c6bda4924a6f660c1c3d964e6",
					"creditCard": {
						"id": "card_1C0CYpCiVhDLJHAGt2bsx9mW",
						"number": "4242",
						"exp_year": 23,
						"exp_month": 12
					},
					"pickUpDate": "2018-03-05T22:14:29.180"
				},
				"code": 200
			}
			"""
		let response = try! Singletons.sharedJSONDecoder.decode(Response<Transaction>.self, from: rawResponse.data(using: .utf8)!)
		let session = URLSessionMock(data: response.toData)
		
		let requester = TransactionsRequester(session: session)
		
		requester.deliver(transactionID: "b9ebe71c6bda4924a6f660c1c3d964e6", userID: "126fb593b8374dfcb2225bd0d9779a12") { (response) in
			XCTAssertEqual(response.code, .ok)
			XCTAssertEqual(response.data?.identifier, "b9ebe71c6bda4924a6f660c1c3d964e6")
			XCTAssertEqual(response.data?.userID, "126fb593b8374dfcb2225bd0d9779a12")
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

