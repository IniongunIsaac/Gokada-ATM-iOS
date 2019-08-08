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
    private(set) var validatePinCalled: Bool = false
    private(set) var withdrawCashCalled: Bool = false
    private(set) var buyAirtimeCalled: Bool = false
    private(set) var getNetworksCalled: Bool = false
    private(set) var cardNumberArg: String = ""
    private(set) var cardPinArg: String = ""
    private(set) var amountArg: String = ""
    private(set) var accountArg: Account!
    private(set) var phoneNoArg: String = ""
    
    
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
        
        validatePinCalled = true
        cardPinArg = cardPin
        
        return cardPin.compare(AppConstants.ATM_CARD_PIN) == .orderedSame
    }
    
    func withdrawCash(amount: String, account: Account) -> ServiceResult {
        
        withdrawCashCalled = true
        amountArg = amount
        accountArg = account
        
        let floatAmount = Float(amount)!
        
        if isMultipleOf500Or1000(number: floatAmount) {
            //Obtain approval from bank before cash is dispensed to user.
            //We assume here that all accounts can maintain a zero balance.
            if (account.balance - floatAmount) > 0.0 {
                return ServiceResult(code: 200, resultType: .success, messageDescription: "Transaction Approved. Please take your cash!", data: Account(type: account.type, number: account.number, balance: account.balance - floatAmount))
            } else {
                return ServiceResult(code: 400, resultType: .failure, messageDescription: "Transaction not approved, insufficient balance.", data: nil)
            }
        }
        
        return ServiceResult(code: 400, resultType: .failure, messageDescription: "Please ensure the amount entered is a multiple of 500 or 1000.", data: nil)
        
    }
    
    func buyAirtime(amount: String, phoneNo: String, account: Account) -> ServiceResult {
        
        buyAirtimeCalled = true
        amountArg = amount
        accountArg = account
        phoneNoArg = phoneNo
        
        let floatAmount = Float(amount)!
        
        //Obtain approval from bank before cash is dispensed to user.
        //We assume here that all accounts can maintain a zero balance.
        if (account.balance - floatAmount) > 0.0 {
            return ServiceResult(code: 200, resultType: .success, messageDescription: "Transaction Approved. Please check \(phoneNo) for purchased airtime!", data: Account(type: account.type, number: account.number, balance: account.balance - floatAmount))
        } else {
            return ServiceResult(code: 400, resultType: .failure, messageDescription: "Transaction not approved, insufficient balance.", data: nil)
        }
    }
    
    func getNetworks() -> [String] {
        
        getNetworksCalled = true
        
        return ["MTN", "Glo", "Airtel", "Etisalat"]
    }

}
