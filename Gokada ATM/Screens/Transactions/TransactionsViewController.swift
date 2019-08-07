//
//  TransactionsViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class TransactionsViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var cardData: CardData!
    var transactionType: TransactionType!
    var account: Account!
    var transactionReceipt: TransactionReceipt!
    
    lazy var presenter = TransactionsPresenter(service: AppConstants.ATM_SERVICE, view: self)
    
    override func getPresenter() -> BasePresenter {
        return presenter
    }
    
    override func viewDidLoad() {
        
        presenter.setCardData(cardData: cardData)
        
        super.viewDidLoad()
        
        //Set navigation bar title
        navigationItem.title = "Transactions"
    }
    
    @IBAction func transactionButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            //Withdraw cash button tapped
            presenter.handleTransactionOperation(transctnType: .withdrawal)
        case 2:
            //Balance Inquiry button tapped
            presenter.handleTransactionOperation(transctnType: .balanceInquiry)
        case 3:
            //Airtime Topup button tapped
            presenter.handleTransactionOperation(transctnType: .airtimeTopup)
        case 4:
            //Cancel button tapped
            dismissVC()
        default:
            print("Invalid Tag!")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.compare("showWithdrawCashViewController") == .orderedSame {
            let vc = segue.destination as! WithdrawCashViewController
            vc.cardData = self.cardData
            vc.selectedAccount = self.account
            vc.transactionType = self.transactionType
        } else if segue.identifier?.compare("showTransactionReceiptViewController") == .orderedSame {
            (segue.destination as! TransactionReceiptViewController).transactionReceipt = self.transactionReceipt
        } else if segue.identifier?.compare("showAirtimeTopupViewController") == .orderedSame {
            let vc = segue.destination as! AirtimeTopupViewController
            vc.cardData = self.cardData
            vc.selectedAccount = self.account
            vc.transactionType = self.transactionType
        }
    }

}

//MARK: - TransactionsView Protocol
extension TransactionsViewController: TransactionsView {
    
    func displayCustomerInfo(customerName: String) {
        nameLabel.text = "Hello, " + customerName
    }
    
    func navigateToViewController(transactionType: TransactionType, cardData: CardData, selectedAccount: Account) {
        
        self.transactionType = transactionType
        self.cardData = cardData
        self.account = selectedAccount
        
        switch transactionType {
        case .withdrawal:
            performSegue(withIdentifier: "showWithdrawCashViewController", sender: nil)
        case .balanceInquiry:
            print("Selection not applicable!")
        case .airtimeTopup:
            performSegue(withIdentifier: "showAirtimeTopupViewController", sender: nil)
        }

    }
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt) {
        self.transactionReceipt = transactionReceipt
        performSegue(withIdentifier: "showTransactionReceiptViewController", sender: nil)
    }
    
}
