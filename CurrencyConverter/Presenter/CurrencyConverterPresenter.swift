//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

protocol CurrencyConverterPresenterView: class {
    func displayValues(_ values: [DataEntry], animated: Bool)
}

typealias CurrencyRate = (Rate, Double)

class CurrencyConverterPresenter {

    // MARK: - Properties

    private weak var view: CurrencyConverterPresenterView?

    private var rates: [CurrencyRate]?

    private var base: Rate = .usd

    private var lastValue: String?

    // MARK: - Helpers

    func attachView(_ view: CurrencyConverterPresenterView?) {
        self.view = view
    }

    func didEnterValue(_ value: String?) {

        resetRates()

        lastValue = value

        guard let value = value,
            let doubleValue = Double(value),
            doubleValue > 0,
            let rates = self.rates,
            let maxRate = rates.max(by: { $0.1 < $1.1 }) else { return }

        let maxValue = maxRate.1 * doubleValue

        let dataEntries: [DataEntry] = rates.compactMap {
            guard $0.0 != base else { return nil }
            let value = (doubleValue * $0.1) / maxValue
            return DataEntry(color: $0.0.color, height: Float(value), textValue: String(format: "%0.2f", doubleValue * $0.1), title: $0.0.name)
        }

        self.view?.displayValues(dataEntries, animated: true)
    }

    private func resetRates() {
        let dataEntries: [DataEntry] = Rate.allRates.compactMap {
            guard $0 != base else { return nil }
            return DataEntry(color: $0.color, height: 0, textValue: "", title: $0.name)
        }

        self.view?.displayValues(dataEntries, animated: false)
    }

    private func getRates() {
        ConverterRepository.getRates(from: base) { [weak self] result in
            switch result {
            case .success(let response):
                let rates: [CurrencyRate] = response.rates.compactMap {
                    guard let rate = Rate(rawValue: $0.key) else { return nil}

                    return (rate, $0.value)
                }

                self?.rates = rates

                self?.didEnterValue(self?.lastValue)
            case .failure(_):
                self?.rates = nil
                break
            }
        }
    }

    func updateRates(for index: Int) {
        guard  let rate = Rate.allRates.first(where: { $0.name == Rate.availableRates[index] }) else {
            return
        }

        base = rate

        getRates()
    }
}
