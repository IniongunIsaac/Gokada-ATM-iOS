//
//  ATMService_Tests.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class ATMService_Tests: XCTestCase {
    
    fileprivate var service: MockATMService!
    fileprivate var testCardNumber = "1234567890"
    fileprivate var testCardPin = "1234"
    fileprivate var testAmountValid = "5000"
    fileprivate var testAmountInvalid = "54890"
    fileprivate var testAccount: Account!
    fileprivate var testPhoneNo = "12345678901"

    override func setUp() {
        service = MockATMService()
        testAccount = Account(type: .savings, number: "1234567890", balance: 85478.89)
    }

    override func tearDown() { }
    
    func test_validateCardCredentials_receivesCorrectArguments() {
        
        let _ = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPin)
        
        XCTAssertTrue(service.validateCardCredentialsCalled)
        XCTAssertEqual(testCardNumber, service.cardNumberArg)
        XCTAssertEqual(testCardPin, service.cardPinArg)
    }

    func test_validateCardCredentials_returnsFailure_givenIncorrectCredentials() {
        
        testCardNumber = "0987654321"
        testCardPin = "4321"
        
        let result = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPin)
        
        XCTAssertEqual(result.code, 400)
        XCTAssertEqual(result.resultType, .failure)
        XCTAssertNil(result.data)
        XCTAssertEqual(result.messageDescription, "Invalid Card Credentials.")
    }
    
    func test_validateCardCredentials_returnsSuccess_givenCorrectCredentials() {
        
        testCardNumber = "1234567890"
        testCardPin = "1234"
        
        let result = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPin)
        
        XCTAssertEqual(result.code, 200)
        XCTAssertEqual(result.resultType, .success)
        XCTAssertNotNil(result.data)
        XCTAssertEqual(result.messageDescription, "Valid Card Credentials.")
    }
    
    func test_validatePin_receivesCorrectArgument() {
        
        let _ = service.validatePin(cardPin: testCardPin)
        
        XCTAssertTrue(service.validatePinCalled)
        XCTAssertEqual(testCardPin, service.cardPinArg)
    }
    
    func test_validatePin_returnsTrue_givenValidPinValue() {
        XCTAssertTrue(service.validatePin(cardPin: testCardPin))
    }
    
    func test_validatePin_returnsFalse_givenInvalidPinValue() {
        
        testCardPin = "4321"
        
        XCTAssertFalse(service.validatePin(cardPin: testCardPin))
    }
    
    func test_withdrawCash_receivesPassedArguments() {
        let _ = service.withdrawCash(amount: testAmountValid, account: testAccount)
        
        XCTAssertTrue(service.withdrawCashCalled)
        XCTAssertEqual(testAmountValid, service.amountArg)
        XCTAssertNotNil(service.accountArg)
        XCTAssertEqual(testAccount.type, service.accountArg.type)
        XCTAssertEqual(testAccount.number, service.accountArg.number)
        XCTAssertEqual(testAccount.balance, service.accountArg.balance)
    }
    
    func test_withdrawCash_returnsFailure_givenNotAMultipleOf500Or1000AmountValue() {
        let result = service.withdrawCash(amount: testAmountInvalid, account: testAccount)
        
        XCTAssertNil(result.data)
        XCTAssertTrue(result.code == 400)
        XCTAssertTrue(result.messageDescription.contains("multiple of 500 or 1000"))
        XCTAssertTrue(result.resultType == .failure)
    }
    
    func test_withdrawCash_returnsFailure_givenAmountGreaterThanBalanceOnAccount() {
        testAmountValid = "100000"
        
        let result = service.withdrawCash(amount: testAmountValid, account: testAccount)
        
        XCTAssertNil(result.data)
        XCTAssertEqual(result.code, 400)
        XCTAssertEqual(result.resultType, .failure)
        XCTAssertEqual(result.messageDescription, "Transaction not approved, insufficient balance.")
    }
    
    func test_withdrawCash_returnsSuccess_givenAmountLessThanBalanceOnAccount() {
        let result = service.withdrawCash(amount: testAmountValid, account: testAccount)
        
        XCTAssertNotNil(result.data)
        XCTAssertEqual(result.code, 200)
        XCTAssertEqual(result.resultType, .success)
        XCTAssertEqual(result.messageDescription, "Transaction Approved. Please take your cash!")
    }
    
    func test_buyAirtime_receivesPassedArguments() {
        let _ = service.buyAirtime(amount: testAmountValid, phoneNo: testPhoneNo, account: testAccount)
        
        XCTAssertTrue(service.buyAirtimeCalled)
        XCTAssertEqual(testAmountValid, service.amountArg)
        XCTAssertEqual(testPhoneNo, service.phoneNoArg)
        XCTAssertNotNil(service.accountArg)
        XCTAssertEqual(testAccount.type, service.accountArg.type)
        XCTAssertEqual(testAccount.number, service.accountArg.number)
        XCTAssertEqual(testAccount.balance, service.accountArg.balance)
        
    }
    
    func test_buyAirtime_returnsFailure_givenAmountGreaterThanBalanceOnAccount() {
        
        testAmountValid = "100000"
        
        let result = service.buyAirtime(amount: testAmountValid, phoneNo: testPhoneNo, account: testAccount)
        
        XCTAssertNil(result.data)
        XCTAssertEqual(result.code, 400)
        XCTAssertEqual(result.resultType, .failure)
        XCTAssertEqual(result.messageDescription, "Transaction not approved, insufficient balance.")
    }
    
    func test_buyAirtime_returnsSuccess_givenAmountLessThanBalanceOnAccount() {
        
        let result = service.buyAirtime(amount: testAmountValid, phoneNo: testPhoneNo, account: testAccount)
        
        XCTAssertNotNil(result.data)
        XCTAssertEqual(result.code, 200)
        XCTAssertEqual(result.resultType, .success)
        XCTAssertEqual(result.messageDescription, "Transaction Approved. Please check \(testPhoneNo) for purchased airtime!")
    }
    
    func test_getNetworks_returnsValidResult() {
        
        let result = service.getNetworks()
        
        XCTAssertTrue(service.getNetworksCalled)
        XCTAssertEqual(result.count, 4)
    }

}
