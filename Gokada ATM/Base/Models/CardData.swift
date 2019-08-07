//
//  CardData.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

struct CardData: DynamicServiceResponse {
    var name: String
    var phoneNo: String
    var address: String
    var linkedAccounts: [Account]
}
