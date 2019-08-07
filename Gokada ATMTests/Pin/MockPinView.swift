//
//  MockPinView.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class MockPinView: PinView {
    
    private(set) var navigateToTransactionsCalled: Bool = false
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
    
    func navigateToTransactions(cardData: CardData) {
        navigateToTransactionsCalled = true
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

}
