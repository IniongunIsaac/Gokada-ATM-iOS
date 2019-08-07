//
//  BaseViewController.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 05/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import UIKit
import ProgressHUD
import Toast
import Alertift
import ChameleonFramework

class BaseViewController: UIViewController, BaseView {
    
    func getPresenter() -> BasePresenter {
        preconditionFailure("Every subclass of \(self) must provide an implementation of BasePresenter protocol")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPresenter().viewDidLoad()
        
        //Configure Toast
        configureToast()
        
        //change navigation bar text and icon colors to white
        navigationController?.navigationBar.tintColor = FlatWhite()
        
        //Dismiss Keyboard when tappped outside any textfield or textview
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPresenter().viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPresenter().viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        getPresenter().viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        getPresenter().viewDidDisappear()
    }
    
    func showAlert(message: String) {
        Alertift.alert(title: "", message: message)
            .action(.default("Dismiss"))
            .show(on: self)
    }
    
    func showAlert(message: String, yesAction: @escaping () -> Void) {
        Alertift.alert(title: "", message: message)
            .action(.default("Okay"))
            .finally{ alertAction, index, textfieldArray in
                yesAction()
            }
            .show(on: self)
    }
    
    func showAlert(message: String, title: String, actionText: String, action: @escaping () -> Void) {
        Alertift.alert(title: "", message: message)
            .action(.default("Dismiss"))
            .show(on: self)
    }
    
    func showLoading() {
        ProgressHUD.show()
    }
    
    func showLoading(with message: String) {
        ProgressHUD.show(message)
    }
    
    func hideLoading() {
        ProgressHUD.dismiss()
    }
    
    func showSuccessAlert() {
        ProgressHUD.showSuccess()
    }
    
    func showSuccessAlert(with message: String) {
        
        Alertift.alert(message: message)
            .image(UIImage(named: "success"), imageTopMargin: .belowRoundCorner)
            .action(.cancel("Okay"))
            .show(on: self)
    }
    
    func showSuccessAlert(with message: String, dismissAction: @escaping () -> Void) {
        Alertift.alert(message: message)
            .image(UIImage(named: "success"), imageTopMargin: .belowRoundCorner)
            .action(.cancel("Okay"))
            .finally({ action, index, textfield  in
                dismissAction()
            })
            .show(on: self)
    }
    
    func showFailureAlert() {
        ProgressHUD.showError()
    }
    
    func showFailureAlert(with message: String) {
        Alertift.alert(message: message)
            .image(UIImage(named: "error"), imageTopMargin: .belowRoundCorner)
            .action(.cancel("Dismiss"))
            .show(on: self)
    }
    
    func showFailureAlert(with message: String, dismissAction: @escaping () -> Void) {
        Alertift.alert(message: message)
            .image(UIImage(named: "error"), imageTopMargin: .belowRoundCorner)
            .action(.cancel("Dismiss"))
            .finally({ action, index, textfield  in
                dismissAction()
            })
            .show(on: self)
    }
    
    func showAlert(with message: String, alertType: AlertType, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        
        let alertImage: UIImage? = alertType == .success ? UIImage(named: "success") : UIImage(named: "error")
        
        Alertift.alert(message: message)
            .image(alertImage, imageTopMargin: .belowRoundCorner)
            .action(.cancel("Dismiss"))
            .action(.default("Okay"))
            .finally({ action, index, textfield  in
                if action.style == .default {
                    yesAction()
                } else {
                    noAction()
                }
            })
            .show(on: self)
    }
    
    func showToast(message: String) {
        self.view.makeToast(message, duration: 2.0, position: CSToastPositionBottom)
    }
    
    func hideToast() {
        self.view.hideAllToasts()
    }
    
    func showConfirmationAlert2(message: String, title: String, yesAction: @escaping () -> Void) {
        
    }
    
    func showConfirmationAlert(message: String, title: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        
    }
    
    func showConfirmationAlert(message: String, title: String, yesText: String, noText: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        
    }
    
    //MARK: - Configure Toast
    fileprivate func configureToast() {
        //Configure toast style
        let toastStyle: CSToastStyle = CSToastStyle.init(defaultStyle: ())
        toastStyle.backgroundColor = mainAppColor
        toastStyle.cornerRadius = 10.0
        toastStyle.messageColor = UIColor.white
        CSToastManager.setSharedStyle(toastStyle)
        CSToastManager.setDefaultDuration(1.5)
        CSToastManager.setDefaultPosition(CSToastPositionBottom)
    }
    
    func runOnMainThread(_ action: @escaping () -> Void) {
        DispatchQueue.main.async {
            action()
        }
    }
    
    func dismissToRootViewController() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(forActions: [String], message: String, handler: @escaping (UIAlertAction, Int) -> Void){
        Alertift.actionSheet(title: message, anchorView: self.view)
            .actions(forActions)
            .action(.cancel("Dismiss"))
            .buttonTextColor(mainAppColor)
            .finally { action, index in
                
                if action.style == .cancel { return }
                handler(action, index)
                
            }.show(on: self)
    }
    
    //Change navigation bar back button text to the value of `backButtonText` or `Back` by default
    func configureNavigationBarBackButton(backButtonText: String = "Back") {
        let backItem = UIBarButtonItem()
        backItem.title = backButtonText
        navigationItem.backBarButtonItem = backItem
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
