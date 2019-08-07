//
//  TransactionReceiptViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class TransactionReceiptViewController: UIViewController {
    
    @IBOutlet weak var customerIntroLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var endingBalanceLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var machineLocationTextView: UITextView!
    
    var transactionReceipt: TransactionReceipt!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set navigation bar title
        navigationItem.title = "Transaction Receipt"
        
        showTransactionReceiptDetails()
    }
    
    fileprivate func showTransactionReceiptDetails() {
        if let trnsctnRcpt = transactionReceipt {
            customerIntroLabel.text = "Dear \(trnsctnRcpt.customerName),"
            dateLabel.text = trnsctnRcpt.date
            timeLabel.text = trnsctnRcpt.time
            transactionTypeLabel.text = trnsctnRcpt.transactionType
            accountLabel.text = trnsctnRcpt.transactionAccount
            transactionAmountLabel.text = trnsctnRcpt.amount
            endingBalanceLabel.text = trnsctnRcpt.endingBalance
            availableBalanceLabel.text = trnsctnRcpt.availableBalance
            machineLocationTextView.text = trnsctnRcpt.machineLocation
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.navigationController?.viewControllers.removeLast()
    }
    
}
