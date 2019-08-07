//
//  PinPresenter_Tests.swift
//  Gokada ATMTests
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import XCTest
@testable import Gokada_ATM

class PinPresenter_Tests: XCTestCase {
    
    fileprivate var service: MockATMService!
    fileprivate var view: MockPinView!
    //SUT
    fileprivate var presenter: PinPresenter!
    
    fileprivate var testCardNumber = "1234567890"
    fileprivate var testCardPin = "1234"

    override func setUp() {
        service = MockATMService()
        view = MockPinView()
        presenter = PinPresenter(service: service, view: view)
    }

    override func tearDown() { }
    
    func test_validatePin_callsShowFailureAlertOnView_givenEmptyPinValue() {
        presenter.validatePin(cardNo: "", pin: "")
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_validatePin_callsShowFailureAlertOnView_givenLoginAttemptsGreaterThanOrEqualThree() {
        presenter.loginFailureAttempts = 3
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        XCTAssertTrue(view.showFailureAlertCalled)
    }
    
    func test_validatePin_callsShowLoadingOnView() {
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        XCTAssertTrue(view.showLoadingCalled)
        
    }
    
    func test_validatePin_callsHideLoadingOnView() {
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        executeAfter {
            XCTAssertTrue(self.view.hideLoadingCalled)
        }
    }
    
    func test_validatePin_callsShowFailureAlertOnView_givenWrongCardCredentials() {
        testCardNumber = "0987654321"
        testCardPin = "4321"
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        executeAfter {
            XCTAssertTrue(self.view.showFailureAlertCalled)
        }
    }
    
    func test_validatePin_callsDismissVCOnView_givenWrongCardCredentials() {
        testCardNumber = "0987654321"
        testCardPin = "4321"
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        executeAfter {
            XCTAssertTrue(self.view.dismissVCCalled)
        }
    }
    
    func test_validatePin_incrementsLoginAttempts_givenWrongCardCredentials() {
        testCardNumber = "0987654321"
        testCardPin = "4321"
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        executeAfter {
            XCTAssertTrue(self.presenter.loginFailureAttempts > 0)
        }
    }
    
    func test_validatePin_callsNavigateToTransactionsOnView_givenCorrectCardCredentials() {
        presenter.validatePin(cardNo: testCardNumber, pin: testCardPin)
        executeAfter {
            XCTAssertTrue(self.view.navigateToTransactionsCalled)
        }
    }

}
