//
//  AppConstants.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import Cleanse

struct AppConstants {
    
    //MARK: - WFMMobileAPIService
    static let ATM_SERVICE: ATMService = try! ComponentFactory.of(AppComponent.self).build(())
    
    //Fake Bank Card Number
    static let BANK_CARD_NUMBER = "1234567890"
    
    //Fake ATM Card PIN
    static let ATM_CARD_PIN = "1234"
    
    //Configure maximum number of times the user can attempt to login using the wrong PIN
    static let MAX_LOGIN_FAILURE_ATTEMPTS = 3
    
    //Failure after three tries error message
    static let PIN_FAILURE_MESSAGE = "You have exhausted the number of times you can attempt to login using the wrong PIN.\nAs a result, your Card has been siezed.\nPlease contact your bank for retrieval."
    
}
