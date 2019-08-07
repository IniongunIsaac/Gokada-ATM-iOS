//
//  AppComponent.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import Cleanse

struct AppComponent: RootComponent {
    
    // When we build this Component we want to return `ATMService`.
    typealias Root = ATMService
    
    static func configure(binder: Binder<AppScope>) {
        //Include AppModule in the AppComponent. It helps resolve the component's dependencies.
        binder.include(module: AppModule.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<ATMService>) -> BindingReceipt<ATMService> {
        return bind.to(factory: { (atmServiceImpl: ATMServiceImpl) -> ATMService in
            atmServiceImpl
        })
    }
    
}
