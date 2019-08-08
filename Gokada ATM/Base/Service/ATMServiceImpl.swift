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
            return ServiceResult(code: 200, resultType: .success, messageDescription: "Valid Card Credentials.", data: CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: getRandomAddress(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3))))
        }
        
        return ServiceResult(code: 400, resultType: .failure, messageDescription: "Invalid Card Credentials.",
                             data: nil)
    }
    
    func validatePin(cardPin: String) -> Bool {
        return cardPin.compare(AppConstants.ATM_CARD_PIN) == .orderedSame
    }
    
    func withdrawCash(amount: String, account: Account) -> ServiceResult {
        
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
        return ["MTN", "Glo", "Airtel", "Etisalat"]
    }
    
}
