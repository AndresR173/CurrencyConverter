//
//  File.swift
//  CurrencyConverterTests
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation
@testable import CurrencyConverter

class MockCurrencyConverterPresenterDelegate: CurrencyConverterPresenterView {

    // MARK: - Properties

    var displayDataEntries: (([DataEntry]) -> Void)?

    // MARK: - Delegate implementation

    func displayValues(_ values: [DataEntry], animated: Bool) {
        displayDataEntries?(values)
    }

}
