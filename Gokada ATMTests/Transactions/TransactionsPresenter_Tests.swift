//
//  TransactionsPresenter_Tests.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 07/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class TransactionsPresenter_Tests: XCTestCase {

    fileprivate var view: MockTransactionsView!
    fileprivate var service: MockATMService!
    fileprivate var presenter: TransactionsPresenter!
    
    fileprivate var testTransactionType: TransactionType = .withdrawal
    fileprivate var cardData: CardData!
    fileprivate var testConfirmationPin = "1234"
    
    override func setUp() {
        view = MockTransactionsView()
        service = MockATMService()
        presenter = TransactionsPresenter(service: service, view: view)
        
        cardData = CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: getRandomAddress(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3)))
        
        presenter.setCardData(cardData: cardData)
    }
    
    override func tearDown() { }
    
    func test_ensureThatCardDataIsSetOnPresenter() {
        XCTAssertNotNil(presenter.cardData)
    }
    
    func test_viewDidLoad_callsDisplayCustomerInfoOnView() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.displayCustomerInfoCalled)
    }
    
    func test_handleTransactionOperation_setsTransactionType() {
        presenter.handleTransactionOperation(transctnType: testTransactionType)
        XCTAssertNotNil(presenter.transactionType)
    }
    
    func test_handleTransactionOperation_callsShowActionSheetOnView() {
        presenter.handleTransactionOperation(transctnType: testTransactionType)
        XCTAssertTrue(view.showActionSheetCalled)
    }
    
    func test_handleTransactionOperation_callsNavigateToViewControllerOnView() {
        presenter.handleTransactionOperation(transctnType: testTransactionType)
        executeAfter {
            XCTAssertTrue(self.view.navigateToViewControllerCalled)
        }
    }
    
    func test_handleTransactionOperation_setsSelectedAccount() {
        presenter.handleTransactionOperation(transctnType: testTransactionType)
        
        executeAfter {
            XCTAssertNotNil(self.presenter.selectedAccount)
        }
        
    }
    
    func test_handleBalanceInquiryTransaction_callsShowFailureAlertOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        presenter.pinConfirmationAttempts = 3
        presenter.handleBalanceInquiryTransaction()
        
        XCTAssertTrue(view.showFailureAlertCalled)
        
    }
    
    func test_handleBalanceInquiryTransaction_callsDismissVCOnView_givenPinConfirmationAttemptsGreaterThanOrEqualThree() {
        
        presenter.pinConfirmationAttempts = 3
        presenter.handleBalanceInquiryTransaction()
        
        executeAfter {
            XCTAssertTrue(self.view.dismissVCCalled)
        }
        
    }
    
    func test_handleBalanceInquiryTransaction_callsShowPinConfirmationAlertOnView() {
        presenter.handleBalanceInquiryTransaction()
        XCTAssertTrue(view.showPinConfirmationAlertCalled)
    }
    
    func test_handleBalanceInquiryTransaction_callsShowFailureAlertOnView_givenEmptyPinValue() {
        presenter.confirmationPin = ""
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_handleBalanceInquiryTransaction_callsShowTransactionInProgressDialogOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showTransactionInProgressDialogCalled)
        }
    }
    
    func test_handleBalanceInquiryTransaction_callsShowSuccessAlertOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.showSuccessAlertCalled)
        }
    }
    
    func test_handleBalanceInquiryTransaction_callsNavigateToTransactionReceiptOnView_givenValidCardPin() {
        presenter.confirmationPin = testConfirmationPin
        
        executeAfter {
            XCTAssertTrue(self.view.navigateToTransactionReceiptCalled)
        }
    }
    
    func test_handleBalanceInquiryTransaction_IncrementsPinConfirmationAttempts_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.presenter.pinConfirmationAttempts > 0)
        }
    }
    
    func test_handleBalanceInquiryTransaction_callsShowFailureAlertOnView_givenInvalidCardPin() {
        presenter.confirmationPin = "4321"
        
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_getTransactionReceipt_returnsValidValue() {
        
        presenter.transactionType = testTransactionType
        let testAccount = Account(type: .savings, number: "1234567890", balance: 85478.89)
        presenter.selectedAccount = testAccount
        
        let trnsctnRcpt = presenter.getTransactionReceipt()
        
        XCTAssertNotNil(trnsctnRcpt)
        XCTAssertEqual(String(describing: testTransactionType).capitalized, trnsctnRcpt.transactionType)
        XCTAssertEqual("\(String(describing: testAccount.type).capitalized) (\(testAccount.number))", trnsctnRcpt.transactionAccount)
    }

}
