//
//  WithdrawCashPresenter.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import Fakery

class WithdrawCashPresenter: BasePresenter {
    
    var service: ATMService!
    var view: WithdrawCashView!
    
    var transactionType: TransactionType!
    var cardData: CardData!
    var account: Account!
    
    var pinConfirmationAttempts = 0
    var confirmationPin = ""
    
    init(service: ATMService, view: WithdrawCashView) {
        self.service = service
        self.view = view
    }
    
    func viewDidLoad() { }
    
    func viewWillAppear() { }
    
    func viewDidAppear() { }
    
    func viewWillDisappear() { }
    
    func viewDidDisappear() { }
    
    func setData(transactionType: TransactionType, cardData: CardData, account: Account) {
        self.transactionType = transactionType
        self.cardData = cardData
        self.account = account
    }
    
    func performCashWithdrawal(amount: String) {
        
        if amount.isEmpty {
            view.showFailureAlert(with: "Please enter an amount!")
        }
        //ensure that the user is not able to continue after AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS failure attempts
        else if self.pinConfirmationAttempts >= AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS {
            self.view.showFailureAlert(with: AppConstants.PIN_FAILURE_MESSAGE) {
                self.view.dismissVC()
            }
        }
        else {
            //This is a security mesure that ensures that the user is able to confirm his/her PIN before proceeding with the transaction
            view.showPinConfirmationAlert { pinValue in
                
                //Set Confirmation pin value
                self.confirmationPin = pinValue
                
                //ensure pinValue is not empty
                if self.confirmationPin.isEmpty {
                    self.view.showFailureAlert(with: "Please enter a PIN!")
                } else {
                     if self.service.validatePin(cardPin: self.confirmationPin) {
                        //Pin is valid, proceed with the transaction
                        let popup = self.view.showTransactionInProgressDialog { }
                        
                        executeAfter(timeInterval: Double(Int.random(in: 1...5))) {
                            //Dismiss transaction in progress dialog
                            popup?.dismiss()
                            
                            //perform cash withdrawal
                            let result = self.service.withdrawCash(amount: amount, account: self.account)
                            
                            //process cash withdrawal result and take actions as needed.
                            switch result.resultType {
                                
                            //Handle successful cash withdrawal
                            case .success:
                                self.view.showSuccessAlert(with: result.messageDescription, dismissAction: {
                                    
                                    //Get Account from result
                                    let resultAccount = result.data as! Account
                                    
                                    //get transaction date and time
                                    let dateTimeStringArr = getCurrentDateTime().components(separatedBy: " ")
                                    
                                    //Get TransactionReceipt
                                    let transReceipt = TransactionReceipt(customerName: self.cardData.name, date: dateTimeStringArr[0], time: dateTimeStringArr[1], machineLocation: getRandomAddress(), transactionType: String(describing: self.transactionType!).capitalized, transactionAccount: "\(String(describing: resultAccount.type).capitalized) (\(resultAccount.number))", amount: String(describing: Float(amount)!), endingBalance: String(describing: resultAccount.balance), availableBalance: String(describing: resultAccount.balance))
                                    
                                    //show transaction receipt for cash withdrawal
                                    self.view.navigateToTransactionReceipt(transactionReceipt: transReceipt)
                                })
                            
                            // Handle failed cash withdrawal transaction
                            case .failure:
                                self.view.showFailureAlert(with: result.messageDescription)
                            }
                        }
                        
                    } else {
                        self.pinConfirmationAttempts = self.pinConfirmationAttempts + 1
                        self.view.showFailureAlert(with: "Invalid PIN, please try again.")
                    }
                    
                }
                
            }
        }
        
    }
    
}
