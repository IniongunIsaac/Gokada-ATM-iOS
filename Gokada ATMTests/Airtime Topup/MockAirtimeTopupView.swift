//
//  MockAirtimeTopupView.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 08/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import PopupDialog
@testable import Gokada_ATM

class MockAirtimeTopupView: AirtimeTopupView {
    
    private(set) var setSelectedNetworkCalled: Bool = false
    private(set) var navigateToTransactionReceiptCalled: Bool = false
    private(set) var showAlertCalled: Bool = false
    private(set) var showSuccessAlertCalled: Bool = false
    private(set) var showFailureAlertCalled: Bool = false
    private(set) var showLoadingCalled: Bool = false
    private(set) var hideLoadingCalled: Bool = false
    private(set) var showToastCalled: Bool = false
    private(set) var hideToastCalled: Bool = false
    private(set) var showConfirmationAlert2Called: Bool = false
    private(set) var showConfirmationAlertCalled: Bool = false
    private(set) var runOnMainThreadCalled: Bool = false
    private(set) var dismissToRootViewControllerCalled: Bool = false
    private(set) var dismissVCCalled: Bool = false
    private(set) var showActionSheetCalled: Bool = false
    private(set) var showPinConfirmationAlertCalled: Bool = false
    private(set) var showTransactionInProgressDialogCalled: Bool = false
    
    func setSelectedNetwork(networkName: String) {
        setSelectedNetworkCalled = true
    }
    
    func navigateToTransactionReceipt(transactionReceipt: TransactionReceipt) {
        navigateToTransactionReceiptCalled = true
    }
    
    func showAlert(message: String) {
        showAlertCalled = true
    }
    
    func showAlert(message: String, yesAction: @escaping () -> Void) {
        showAlertCalled = true
    }
    
    func showAlert(message: String, title: String, actionText: String, action: @escaping () -> Void) {
        showAlertCalled = true
    }
    
    func showAlert(with message: String, alertType: AlertType, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        showAlertCalled = true
    }
    
    func showSuccessAlert() {
        showSuccessAlertCalled = true
    }
    
    func showSuccessAlert(with message: String) {
        showSuccessAlertCalled = true
    }
    
    func showSuccessAlert(with message: String, dismissAction: @escaping () -> Void) {
        showSuccessAlertCalled = true
    }
    
    func showFailureAlert() {
        showFailureAlertCalled = true
    }
    
    func showFailureAlert(with message: String) {
        showFailureAlertCalled = true
    }
    
    func showFailureAlert(with message: String, dismissAction: @escaping () -> Void) {
        showFailureAlertCalled = true
    }
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func showLoading(with message: String) {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showToast(message: String) {
        showToastCalled = true
    }
    
    func hideToast() {
        hideToastCalled = true
    }
    
    func showConfirmationAlert2(message: String, title: String, yesAction: @escaping () -> Void) {
        showConfirmationAlert2Called = true
    }
    
    func showConfirmationAlert(message: String, title: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        showConfirmationAlertCalled = true
    }
    
    func showConfirmationAlert(message: String, title: String, yesText: String, noText: String, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        showConfirmationAlertCalled = true
    }
    
    func runOnMainThread(_ action: @escaping () -> Void) {
        runOnMainThreadCalled = true
    }
    
    func dismissToRootViewController() {
        dismissToRootViewControllerCalled = true
    }
    
    func dismissVC() {
        dismissVCCalled = true
    }
    
    func showActionSheet(forActions: [String], message: String, handler: @escaping (UIAlertAction, Int) -> Void) {
        showActionSheetCalled = true
    }
    
    func showPinConfirmationAlert(handler: @escaping (String) -> Void) {
        showPinConfirmationAlertCalled = true
    }
    
    func showTransactionInProgressDialog(dismissAction: @escaping () -> Void) -> PopupDialog? {
        showTransactionInProgressDialogCalled = true
        return nil
    }
    
}
