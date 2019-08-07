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
    
    var service: MockATMService!
    fileprivate let testCardNumber = "1234567890"
    fileprivate let testCardPin = "1234"

    override func setUp() {
        service = MockATMService()
    }

    override func tearDown() { }
    
    func test_validateCardCredentials_receivesCorrectArguments() {
        
        let _ = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPin)
        
        XCTAssertTrue(service.validateCardCredentialsCalled)
        XCTAssertEqual(testCardNumber, service.cardNumberArg)
        XCTAssertEqual(testCardPin, service.cardPinArg)
    }

    func test_validateCardCredentials_returnsFailure_givenIncorrectCredentials() {
        
        let testCardNumber = "0987654321"
        let testCardPIN = "4321"
        
        let result = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPIN)
        
        XCTAssertEqual(result.code, 400)
        XCTAssertEqual(result.resultType, .failure)
        XCTAssertNil(result.data)
        XCTAssertEqual(result.messageDescription, "Invalid Card Credentials.")
    }
    
    func test_validateCardCredentials_returnsSuccess_givenCorrectCredentials() {
        
        let testCardNumber = "1234567890"
        let testCardPIN = "1234"
        
        let result = service.validateCardCredentials(cardNumber: testCardNumber, cardPin: testCardPIN)
        
        XCTAssertEqual(result.code, 200)
        XCTAssertEqual(result.resultType, .success)
        XCTAssertNotNil(result.data)
        XCTAssertEqual(result.messageDescription, "Valid Card Credentials.")
    }

}
