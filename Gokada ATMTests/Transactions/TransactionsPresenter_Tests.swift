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

    var view: MockTransactionsView!
    var presenter: TransactionsPresenter!
    
    var testTransactionType: TransactionType = .withdrawal
    
    var cardData: CardData!
    
    override func setUp() {
        view = MockTransactionsView()
        
        presenter = TransactionsPresenter(view: view)
        
        cardData = CardData(name: faker.name.name(), phoneNo: faker.phoneNumber.phoneNumber(), address: faker.address.streetAddress(includeSecondary: true) + ", " + faker.address.city() + ", " + faker.address.state() + ", " + faker.address.country(), linkedAccounts: getLinkedAccounts(numberOfAccounts: Int.random(in: 1...3)))
        
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

}
