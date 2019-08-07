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
}
