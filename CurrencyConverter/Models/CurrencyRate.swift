//
//  CurrencyRate.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct CurrencyRate {
    let rate: Rate
    let value: Double

    func getValue(for currencyRate: Double) -> Double {
        return currencyRate * value
    }
}

extension Array where Element == CurrencyRate {
    func getDataEntries(for base: Rate, value: Double) -> [DataEntry] {
        let rates = self.filter { $0.rate != base}
        let maxValue = (rates.max(by: { $0.value < $1.value })?.value ?? 1) * value
        return rates.compactMap { rate in
            let height = rate.getValue(for: value) / maxValue
            return DataEntry(color: rate.rate.color, height: Float(height), textValue: String(format: "%0.2f", rate.getValue(for: value)), title: rate.rate.rawValue)
        }
    }
}
