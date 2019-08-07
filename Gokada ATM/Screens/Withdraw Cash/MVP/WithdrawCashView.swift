//
//  WithdrawCashView.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol WithdrawCashView: BaseView {
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt)
}
