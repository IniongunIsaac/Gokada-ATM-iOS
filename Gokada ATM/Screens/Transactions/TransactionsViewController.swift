//
//  TransactionsViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var cardData: CardData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation bar title
        navigationItem.title = "Transactions"
        
        displayCustomerInfo()
    }
    
    fileprivate func displayCustomerInfo() {
        nameLabel.text = "Hello, " + cardData.name
    }
    
    @IBAction func transactionButtonTapped(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 0:
            //Withdrawal cash button tapped
            print("")
        case 1:
            //Balance Inquiry button tapped
            print("")
        case 2:
            //Airtime Topup button tapped
            print("")
        case 3:
            //Cancel button tapped
            dismiss(animated: true, completion: nil)
        default:
            print("Invalid Tag!")
        }
        
    }

}
