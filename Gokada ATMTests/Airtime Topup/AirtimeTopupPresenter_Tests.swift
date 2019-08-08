//
//  AirtimeTopupPresenter_Tests.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 08/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class AirtimeTopupPresenter_Tests: XCTestCase {

    fileprivate var view: MockAirtimeTopupView!
    fileprivate var service: MockATMService!
    fileprivate var presenter: AirtimeTopupPresenter!
    
    fileprivate var testTransactionType: TransactionType!
    fileprivate var testCardData: CardData!
    fileprivate var testAccount: Account!
    fileprivate var testAmount = "5000"
    fileprivate var testConfirmationPin = "1234"
    fileprivate var testPhoneNumber = "12345678901"
    
    override func setUp() {
        
        view = MockAirtimeTopupView()
        service = MockATMService()
        presenter = AirtimeTopupPresenter(service: service, view: view)
        
        testTransactionType = .airtimeTopup
        testAccount = Account(type: .savings, number: "1234567890", balance: 85478.89)
        testCardData = CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: getRandomAddress(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3)))
        
        presenter.setData(transactionType: testTransactionType, cardData: testCardData, account: testAccount)
    }
    
    override func tearDown() { }
    
    func test_setData_isCalledAndDataIsSet() {
        
        XCTAssertNotNil(presenter.account)
        XCTAssertNotNil(presenter.cardData)
        XCTAssertNotNil(presenter.transactionType)
        
        XCTAssertEqual(presenter.transactionType, testTransactionType)
        XCTAssertEqual(presenter.cardData.name, testCardData.name)
        XCTAssertEqual(presenter.account.number, testAccount.number)
    }
    
    func test_performRechargeOperation_callsShowFailureAlert_givenEmptyAmountValue() {
        testAmount = ""
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performRechargeOperation_callsShowFailureAlert_givenEmptyPhoneValue() {
        testPhoneNumber = ""
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performRechargeOperation_callsShowFailureAlert_givenEmptyPhoneValueLessThanElevenDigits() {
        testPhoneNumber = "1234567890"
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performRechargeOperation_callsShowFailureAlert_givenEmptyPhoneValueGreaterThanElevenDigits() {
        testPhoneNumber = "123456789011"
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performRechargeOperation_callsShowFailureAlertOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        presenter.pinConfirmationAttempts = 3
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performRechargeOperation_callsDismissVCOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        presenter.pinConfirmationAttempts = 3
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        
        executeAfter {
            XCTAssertTrue(self.view.dismissVCCalled)
        }
    }
    
    func test_performRechargeOperation_callsShowPinConfirmationAlertOnView() {
        presenter.performRechargeOperation(amount: testAmount, phoneNo: testPhoneNumber)
        XCTAssertTrue(view.showPinConfirmationAlertCalled)
    }
    
    func test_performRechargeOperation_callsShowFailureAlertOnView_givenEmptyPinValue() {
        presenter.confirmationPin = ""
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_performRechargeOperation_callsShowTransactionInProgressDialogOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showTransactionInProgressDialogCalled)
        }
    }
    
    func test_performRechargeOperation_callsShowSuccessAlertOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showSuccessAlertCalled)
        }
    }
    
    func test_performRechargeOperation_callsNavigateToTransactionReceiptOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.navigateToTransactionReceiptCalled)
        }
    }
    
    func test_performRechargeOperation_incrementsPinConfirmationAttempts_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.presenter.pinConfirmationAttempts > 0)
        }
    }
    
    func test_performRechargeOperation_callsShowFailureAlertOnView_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_getAvailableNetworks_callsShowActionSheetOnView() {
        let _ = presenter.getAvailableNetworks()
        
        XCTAssertTrue(view.showActionSheetCalled)
    }
    
    func test_getAvailableNetworks_setsSelectedNetwork() {
        let _ = presenter.getAvailableNetworks()
        
        executeAfter {
            XCTAssertTrue(!self.presenter.selectedNetwork!.isEmpty)
        }
    }
    
    func test_getAvailableNetworks_callsSetSelectedNetworkOnView() {
        let _ = presenter.getAvailableNetworks()
        
        executeAfter {
            XCTAssertTrue(self.view.setSelectedNetworkCalled)
        }
    }

}
