//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class RatesResponseTests: XCTestCase {

    var data: Data!
    let decoder = JSONDecoder()

    override func setUp() {
        let bundle = Bundle(for: RatesResponseTests.self)
        let url = bundle.url(forResource: "rates", withExtension: "json")!
        self.data =  try! Data(contentsOf: url)

        decoder.dateDecodingStrategy = .formatted(DateFormatter.versionFormatter)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAvailableConversionRates() {
        do {
            let response = try decoder.decode(RatesResponse.self, from: data)
            XCTAssert(response.rates.count == 52)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecoding() {
        XCTAssertNoThrow(try decoder.decode(RatesResponse.self, from: data))
    }

    func testDataEntries() {
        let response = try! decoder.decode(RatesResponse.self, from: data)
        let rates = response.rates.getRates()

        let dataEntries = rates.getDataEntries(for: .cop, value: 1)

        XCTAssertTrue(dataEntries.first(where: { $0.title == Rate.cop.rawValue }) == nil &&  dataEntries.count == 2, "Available rates should be 2")
    }

    func testCurrencyConversion() {
        let response = try! decoder.decode(RatesResponse.self, from: data)
        let rates = response.rates.getRates()

        guard let cop = rates.first(where: { $0.rate == .cop }) else {
            XCTFail("COP not found")
            return
        }

        XCTAssert(cop.getValue(for: 1) == 178.173913)
    }

}
