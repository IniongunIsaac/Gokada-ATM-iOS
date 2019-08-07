//
//  PinView.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol PinView: BaseView {
    func navigateToTransactions(cardData: CardData)
}
