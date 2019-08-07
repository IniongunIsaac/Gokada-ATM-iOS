//
//  TransactionsView.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol TransactionsView: BaseView {
    
    func displayCustomerInfo(customerName: String)
    
    func navigateToViewController(transactionType: TransactionType, cardData: CardData, selectedAccount: Account)
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt)
    
}
