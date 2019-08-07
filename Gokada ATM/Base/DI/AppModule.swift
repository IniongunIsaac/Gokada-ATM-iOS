//
//  AppModule.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import Cleanse

struct AppModule: Module {
    
    static func configure(binder: Binder<AppScope>) {
        
        //Provide ATMServiceImpl
        binder.bind(ATMServiceImpl.self)
            .sharedInScope()
            .to(value: ATMServiceImpl())
        
    }
    
}
