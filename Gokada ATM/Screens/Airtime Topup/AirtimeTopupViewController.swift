//
//  AirtimeTopupViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class AirtimeTopupViewController: UIViewController {
    
    @IBOutlet weak var chooseNetworkButton: UIButton!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var phoneNoTextfield: UITextField!

    var transactionType: TransactionType!
    var cardData: CardData!
    var selectedAccount: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set navigation bar title
        navigationItem.title = "Airtime Topup"
    }
    
    @IBAction func chooseNetworkButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func rechargeButtonTapped(_ sender: UIButton) {
    }
    
}
