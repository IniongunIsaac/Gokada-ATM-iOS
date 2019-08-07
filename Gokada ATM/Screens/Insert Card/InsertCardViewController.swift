//
//  InsertPinViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit

class InsertCardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    @IBAction func insertCardButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showPinViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Configure back button text to be shown on PinViewController
        configureNavigationBarBackButton()
        
        //Pass inserted card number to PinViewController
        (segue.destination as! PinViewController).bankCardNumber = AppConstants.BANK_CARD_NUMBER
    }
    
    //Change navigation bar back button text to the value of `backButtonText` or `Back` by default
    private func configureNavigationBarBackButton(backButtonText: String = "Back") {
        let backItem = UIBarButtonItem()
        backItem.title = backButtonText
        navigationItem.backBarButtonItem = backItem
    }
    
}
