//
//  CurrencyConverterPresenterTest.swift
//  CurrencyConverterTests
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterPresenterTest: XCTestCase {

    let presenter = CurrencyConverterPresenter()

    override func setUp() {
        presenter.updateRates(for: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplayedValuesCount() {
        let expectation = XCTestExpectation(description: "Wait for the delegate to be called")

        let presenterDelegate = MockCurrencyConverterPresenterDelegate()

        presenter.attachView(presenterDelegate)

        presenterDelegate.displayDataEntries = { dataEntries in
            expectation.fulfill()
            XCTAssertTrue(dataEntries.count == 2)
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testNewCurrencySelected() {
        let expectation = XCTestExpectation(description: "Wait for the delegate to be called")

        let presenterDelegate = MockCurrencyConverterPresenterDelegate()

        presenter.attachView(presenterDelegate)

        presenterDelegate.displayDataEntries = { dataEntries in
            expectation.fulfill()
            XCTAssertNil(dataEntries.first(where: { $0.title == Rate.mxn.rawValue }))
        }

        presenter.updateRates(for: 1)

        wait(for: [expectation], timeout: 2.0)
    }

}
