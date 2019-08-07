//
//  MockATMServiceImpl.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class MockATMService: ATMService {
    
    private(set) var validateCardCredentialsCalled: Bool = false
    private(set) var cardNumberArg: String = ""
    private(set) var cardPinArg: String = ""
    
    
    func validateCardCredentials(cardNumber: String, cardPin: String) -> ServiceResult {
        
        validateCardCredentialsCalled = true
        cardNumberArg = cardNumber
        cardPinArg = cardPin
        
        if cardNumber.compare(AppConstants.BANK_CARD_NUMBER) == .orderedSame && cardPin.compare(AppConstants.ATM_CARD_PIN) == .orderedSame {
            return ServiceResult(code: 200, resultType: .success, messageDescription: "Valid Card Credentials.", data: CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: faker.address.streetAddress(includeSecondary: true) + ", " + faker.address.city() + ", " + faker.address.state() + ", " + faker.address.country(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3))))
        }
        
        return ServiceResult(code: 400, resultType: .failure, messageDescription: "Invalid Card Credentials.",
                             data: nil)
    }
    
    func validatePin(cardPin: String) -> Bool {
        return cardPin.compare(AppConstants.ATM_CARD_PIN) == .orderedSame
    }

}
