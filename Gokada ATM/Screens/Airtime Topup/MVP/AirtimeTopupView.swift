//
//  AirtimeTopupView.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol AirtimeTopupView: BaseView {
    
    func setSelectedNetwork(networkName: String)
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt)
}
