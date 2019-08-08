//
//  TransactionsPresenter.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

class TransactionsPresenter: BasePresenter {
    
    var service: ATMService!
    let view: TransactionsView
    
    var transactionType: TransactionType!
    var cardData: CardData!
    var selectedAccount: Account!
    var confirmationPin = ""
    
    var pinConfirmationAttempts = 0
    
    init(service: ATMService, view: TransactionsView) {
        self.view = view
        self.service = service
    }
    
    func viewDidLoad() {
        view.displayCustomerInfo(customerName: cardData.name)
    }
    
    func viewWillAppear() {}
    
    func viewDidAppear() {}
    
    func viewWillDisappear() {}
    
    func viewDidDisappear() {}
    
    func setCardData(cardData: CardData) {
        self.cardData = cardData
    }
    
    func handleTransactionOperation(transctnType: TransactionType) {
        transactionType = transctnType
        
        view.showActionSheet(forActions: cardData.linkedAccounts.map({ account -> String in
            return "\(String(describing: account.type).capitalized) (\(account.number)) N\(account.balance)"
        }), message: "Choose Account") { action, index in
            
            //Set selected account details
            self.selectedAccount = self.cardData.linkedAccounts[index]
            
            //Handle balance inquiry transactions
            if transctnType == .balanceInquiry {
                self.handleBalanceInquiryTransaction()
            }
            //Handle withdrawal and airtime topup transactions
            else {
                self.view.navigateToViewController(transactionType: self.transactionType!, cardData: self.cardData, selectedAccount: self.selectedAccount!)
            }
            
        }
        
    }
    
    func handleBalanceInquiryTransaction() {
        
        //ensure that the user is not able to continue after AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS failure attempts
        if self.pinConfirmationAttempts >= AppConstants.MAX_LOGIN_FAILURE_ATTEMPTS {
            self.view.showFailureAlert(with: AppConstants.PIN_FAILURE_MESSAGE) {
                self.view.dismissVC()
            }
        } else {
            //This is a security mesure that ensures that the user is able to confirm his/her PIN before proceeding with the transaction
            view.showPinConfirmationAlert { pinValue in
                
                //Set confirmationPin
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
                            
                            //perform balance inquiry and navigate to TransactionReceiptViewController
                            self.view.showSuccessAlert(with: "Transaction Approved.") {
                                self.view.navigateToTransactionReceipt(transactionReceipt: self.getTransactionReceipt())
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
    
    func getTransactionReceipt() -> TransactionReceipt {
        
        //get transaction date and time
        let dateTimeStringArr = getCurrentDateTime().components(separatedBy: " ")
        
        //Return TransactionReceipt
        return TransactionReceipt(customerName: cardData.name, date: dateTimeStringArr[0], time: dateTimeStringArr[1], machineLocation: getRandomAddress(), transactionType: String(describing: transactionType!).capitalized, transactionAccount: "\(String(describing: selectedAccount!.type).capitalized) (\(selectedAccount!.number))", amount: String(describing: selectedAccount!.balance), endingBalance: String(describing: selectedAccount!.balance), availableBalance: String(describing: selectedAccount!.balance))
        
    }
    
}
