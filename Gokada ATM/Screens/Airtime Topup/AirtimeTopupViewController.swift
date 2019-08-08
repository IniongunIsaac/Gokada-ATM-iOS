//
//  AirtimeTopupViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class AirtimeTopupViewController: BaseViewController {
    
    @IBOutlet weak var chooseNetworkButton: UIButton!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var phoneNoTextfield: UITextField!

    var transactionType: TransactionType!
    var cardData: CardData!
    var selectedAccount: Account!
    var transactionReceipt: TransactionReceipt!
    
    lazy var presenter = AirtimeTopupPresenter(service: AppConstants.ATM_SERVICE, view: self)
    
    override func getPresenter() -> BasePresenter {
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set navigation bar title
        navigationItem.title = "Airtime Topup"
        
        presenter.setData(transactionType: transactionType, cardData: cardData, account: selectedAccount)
    }
    
    @IBAction func chooseNetworkButtonTapped(_ sender: UIButton) {
        presenter.getAvailableNetworks()
    }
    
    @IBAction func rechargeButtonTapped(_ sender: UIButton) {
        presenter.performRechargeOperation(amount: amountTextfield.text!, phoneNo: phoneNoTextfield.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! TransactionReceiptViewController).transactionReceipt = self.transactionReceipt
    }
    
}

//MARK: - AirtimeTopupView Protocol
extension AirtimeTopupViewController: AirtimeTopupView {
    
    func setSelectedNetwork(networkName: String) {
        chooseNetworkButton.changeButtonTitle(to: networkName)
    }
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt) {
        self.transactionReceipt = transactionReceipt
        performSegue(withIdentifier: "showTransactionReceiptViewController", sender: nil)
    }
}
