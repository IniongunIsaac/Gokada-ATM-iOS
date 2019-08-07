//
//  ATMService.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol ATMService {
    
    ///Validates Bank Card Credeentials
    /// - Parameters:
    ///     - cardNumber: A String representing the inserted ATM Card Number as contained on the ATM Card.
    ///     - cardPin: A String representing the inserted ATM Card's PIN.
    /// - Returns: ServiceResult describing the result of the validation.
    func validateCardCredentials(cardNumber: String, cardPin: String) -> ServiceResult
    
    ///Confirms whether or not the PIN on the Card is Valid
    /// - Parameters:
    ///     cardPin: A String reprensenting the pin supplied by the user.
    /// - Returns: A Bool that indicates whether or not the pin is valid.
    func validatePin(cardPin: String) -> Bool
    
    ///Make a withdrawal operation.
    /// - Parameters:
    ///     - amount: A string representing the amount to be withdrawn
    ///     - account: `Account` to be withdrawn from.
    /// - Returns: `ServiceResult` representing the result of the withdrawal operation
    func withdrawCash(amount: String, account: Account) -> ServiceResult
}
