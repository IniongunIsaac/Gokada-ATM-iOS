//
//  ATMServiceImpl.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

class ATMServiceImpl: ATMService {
    
    func validateCardCredentials(cardNumber: String, cardPin: String) -> ServiceResult {
        
        if cardNumber.compare(AppConstants.BANK_CARD_NUMBER) == .orderedSame && cardPin.compare(AppConstants.ATM_CARD_PIN) == .orderedSame {
            return ServiceResult(code: 200, resultType: .success, messageDescription: "Valid Card Credentials.", data: CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: faker.address.streetAddress(includeSecondary: true) + ", " + faker.address.city() + ", " + faker.address.state() + ", " + faker.address.country(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3))))
        }
        
        return ServiceResult(code: 400, resultType: .failure, messageDescription: "Invalid Card Credentials.",
                             data: nil)
    }
    
    fileprivate func getLinkedAccounts(numberOfAccounts: Int) -> [Account] {
        var accounts = [Account]()
        
        for _ in 0..<numberOfAccounts {
            accounts.append(Account(type: getAccountType(Int.random(in: 1...3)), number: generateRandomDigits(11), balance: faker.number.randomFloat(min: 1000.0000, max: 100000.9999)))
        }
        
        return accounts
    }
    
    fileprivate func getAccountType(_ random: Int) -> AccountType {
        switch random {
        case 2:
            return .debit
        case 3:
            return .credit
        default:
            return .savings
        }
    }
}