//
//  ServiceResult.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

struct ServiceResult {
    var code: Int
    var resultType: ServiceResultType
    var messageDescription: String
    var data: DynamicServiceResponse?
}
