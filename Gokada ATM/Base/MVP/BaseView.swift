//
//  BaseView.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation

protocol BaseView {
    
    func showAlert(message: String)
    
    func showAlert(message: String, yesAction: @escaping () -> Void)
    
    func showAlert(message: String, title: String, actionText: String, action: @escaping () -> Void)
    
    func showAlert(with message: String, alertType: AlertType, yesAction: @escaping () -> Void, noAction: @escaping () -> Void)
    
    func showSuccessAlert()
    
    func showSuccessAlert(with message: String)
    
    func showSuccessAlert(with message: String, dismissAction: @escaping () -> Void)
    
    func showFailureAlert()
    
    func showFailureAlert(with message: String)
    
    func showFailureAlert(with message: String, dismissAction: @escaping () -> Void)
    
    func showLoading()
    
    func showLoading(with message: String)
    
    func hideLoading()
    
    func showToast(message: String)
    
    func hideToast()
    
    func showConfirmationAlert2(message: String, title: String, yesAction: @escaping () -> Void)
    
    func showConfirmationAlert(message: String, title: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void)
    
    func showConfirmationAlert(message: String, title: String, yesText: String, noText: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void)
    
    func runOnMainThread(_ action: @escaping () -> Void)
    
    func dismissToRootViewController()
    
    func dismissVC()
    
}
