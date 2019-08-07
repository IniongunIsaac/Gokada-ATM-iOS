//
//  PinPresenter.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

class PinPresenter: BasePresenter {
    
    let service: ATMService
    let view: PinView
    
    init(service: ATMService, view: PinView) {
        self.service = service
        self.view = view
    }
    
    //Variable used to keep track of how many times the use has tried to login using the incorrect PIN
    var loginFailureAttempts = 0
    
    func viewDidLoad() { }
    
    func viewWillAppear() { }
    
    func viewDidAppear() { }
    
    func viewWillDisappear() { }
    
    func viewDidDisappear() { }
    
    func validatePin(cardNo: String, pin: String) {
        
        //PIN must not be empty
        if pin.isEmpty {
            self.view.showFailureAlert(with: "Please enter a PIN.")
        }
        //ensure that the user stays within the AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS number of login attempts
        else if loginFailureAttempts >= AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS {
            view.showFailureAlert(with: "You have exhausted the number of times you can attempt to login using the wrong PIN.\nAs a result, your Card has been siezed.\nPlease contact your bank for retrieval.") {
                self.view.dismissVC()
            }
        } else {
            
            self.view.showLoading(with: "Validating card credentials, please wait...")
            
            //Delay execution for any (1-5)seconds to simulate an actual API call.
            executeAfter(timeInterval: Double(Int.random(in: 1...5))) {
                
                self.view.hideLoading()
                
                let result = self.service.validateCardCredentials(cardNumber: cardNo, cardPin: pin)
                
                if result.resultType == .failure {
                    self.loginFailureAttempts = self.loginFailureAttempts + 1
                    self.view.showFailureAlert(with: result.messageDescription)
                } else {
                    self.view.navigateToTransactions(cardData: result.data as! CardData)
                }
                
            }
        }
        
    }
    
}
