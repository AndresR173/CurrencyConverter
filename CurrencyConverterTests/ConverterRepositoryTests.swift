//
//  RatesRepositoryTests.swift
//  CurrencyConverterTests
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class ConverterRepositoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPITimeout() {
        let expectation = XCTestExpectation()

        ConverterRepository.getRates(from: .cop) { _ in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

}
