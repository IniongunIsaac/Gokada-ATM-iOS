//
//  PinViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class PinViewController: BaseViewController {
    
    @IBOutlet weak var pinTextfield: TextfieldWithAttributes!
    
    //Lazily intialize PinPresenter
    lazy var presenter = PinPresenter(service: AppConstants.ATM_SERVICE, view: self)
    
    var bankCardNumber: String?
    
    fileprivate var cardData: CardData!
    
    //Implemenent getPresenter() from BaseViewController
    override func getPresenter() -> BasePresenter {
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation bar title
        navigationItem.title = "Card PIN"
        
        //Set pinTextfield delegate
        pinTextfield.delegate = self
    }
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        presenter.validatePin(cardNo: bankCardNumber!, pin: pinTextfield.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Configure back button text to be shown on PinViewController
        configureNavigationBarBackButton()
        (segue.destination as! TransactionsViewController).cardData = self.cardData
    }
    
}

//MARK: - PinView Protocol
extension PinViewController: PinView {
    
    func navigateToTransactions(cardData: CardData) {
        self.cardData = cardData
        performSegue(withIdentifier: "showTransactionsViewController", sender: nil)
    }
    
}

//MARK: - UITextFieldDelegate Protocol
extension PinViewController: UITextFieldDelegate {
    //Limit number of characters for textfield to 4
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}
