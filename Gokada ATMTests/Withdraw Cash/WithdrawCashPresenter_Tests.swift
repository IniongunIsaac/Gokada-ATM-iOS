//
//  WithdrawCashPresenter_Tests.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 08/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class WithdrawCashPresenter_Tests: XCTestCase {
    
    fileprivate var view: MockWithdrawCashView!
    fileprivate var service: MockATMService!
    fileprivate var presenter: WithdrawCashPresenter!
    
    fileprivate var testTransactionType: TransactionType!
    fileprivate var testCardData: CardData!
    fileprivate var testAccount: Account!
    fileprivate var testAmount = "5000"
    fileprivate var testConfirmationPin = "1234"

    override func setUp() {
        
        view = MockWithdrawCashView()
        service = MockATMService()
        presenter = WithdrawCashPresenter(service: service, view: view)
        
        testTransactionType = .withdrawal
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
    
    func test_performCashWithdrawal_callsShowFailureAlert_givenEmptyAmountValue() {
        testAmount = ""
        presenter.performCashWithdrawal(amount: testAmount)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performCashWithdrawal_callsShowFailureAlertOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        presenter.pinConfirmationAttempts = 3
        presenter.performCashWithdrawal(amount: testAmount)
        
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_performCashWithdrawal_callsDismissVCOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        presenter.pinConfirmationAttempts = 3
        presenter.performCashWithdrawal(amount: testAmount)
        
        executeAfter {
            XCTAssertTrue(self.view.dismissVCCalled)
        }
    }
    
    func test_performCashWithdrawal_callsShowPinConfirmationAlertOnView() {
        presenter.performCashWithdrawal(amount: testAmount)
        XCTAssertTrue(view.showPinConfirmationAlertCalled)
    }
    
    func test_performCashWithdrawal_callsShowFailureAlertOnView_givenEmptyPinValue() {
        presenter.confirmationPin = ""
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_performCashWithdrawal_callsShowTransactionInProgressDialogOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showTransactionInProgressDialogCalled)
        }
    }
    
    func test_performCashWithdrawal_callsShowSuccessAlertOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showSuccessAlertCalled)
        }
    }
    
    func test_performCashWithdrawal_callsNavigateToTransactionReceiptOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.navigateToTransactionReceiptCalled)
        }
    }
    
    func test_performCashWithdrawal_incrementsPinConfirmationAttempts_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.presenter.pinConfirmationAttempts > 0)
        }
    }
    
    func test_performCashWithdrawal_callsShowFailureAlertOnView_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }

}
