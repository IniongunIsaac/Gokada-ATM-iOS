//
//  WithdrawCashViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class WithdrawCashViewController: BaseViewController {
    
    @IBOutlet weak var amountTextfield: TextfieldWithAttributes!
    
    var transactionType: TransactionType!
    var cardData: CardData!
    var selectedAccount: Account!
    var transactionReceipt: TransactionReceipt!
    
    lazy var presenter: WithdrawCashPresenter = WithdrawCashPresenter(service: AppConstants.ATM_SERVICE, view: self)
    
    override func getPresenter() -> BasePresenter {
        return presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set navigation bar title
        navigationItem.title = "Withdraw Cash"
        
        presenter.setData(transactionType: transactionType, cardData: cardData, account: selectedAccount)
    }

    @IBAction func withdrawCashButtonTapped(_ sender: UIButton) {
        presenter.performCashWithdrawal(amount: amountTextfield.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! TransactionReceiptViewController).transactionReceipt = self.transactionReceipt
    }
}

//MARK: - WithdrawCashView Protocol
extension WithdrawCashViewController: WithdrawCashView {
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt) {
        self.transactionReceipt = transactionReceipt
        performSegue(withIdentifier: "showTransactionReceiptViewController", sender: nil)
    }
    
}
