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
    func didConvertRatesFailure()
}

typealias CurrencyRate = (Rate, Double)

class CurrencyConverterPresenter {

    // MARK: - Properties

    private weak var view: CurrencyConverterPresenterView?

    private var rates: [CurrencyRate]?

    private var base: Rate = .usd

    // MARK: - LifeCycle

    init() {
        getRates()
    }

    // MARK: - Helpers

    func attachView(_ view: CurrencyConverterPresenterView?) {
        self.view = view
    }

    func didEnterValue(_ value: String?) {

        resetRates()

        guard let value = value,
            let doubleValue = Double(value),
            doubleValue > 0,
            let rates = self.rates,
            let maxRate = rates.max(by: { $0.1 < $1.1 }) else { return }

        let maxValue = maxRate.1 * doubleValue

        let dataEntries: [DataEntry] = rates.compactMap {
            let value = (doubleValue * $0.1) / maxValue
            return DataEntry(color: $0.0.color, height: Float(value), textValue: String(format: "%0.2f", doubleValue * $0.1), title: $0.0.name)
        }

        self.view?.displayValues(dataEntries, animated: true)
    }

    private func resetRates() {
        let dataEntries: [DataEntry] = Rate.allRates.compactMap {
            guard $0 != base else { return nil}
            return DataEntry(color: $0.color, height: 0, textValue: "", title: $0.name)
        }

        self.view?.displayValues(dataEntries, animated: false)
    }

    private func getRates() {

        let symbols: String = Rate.allRates.compactMap {
            if $0 != base {
                return $0.rawValue
            }
            return nil
        }.joined(separator: ",")

        ConverterRepository.getRates(from: base, to: symbols) { [weak self] result in
            switch result {
            case .success(let response):
                let rates: [CurrencyRate] = response.rates.compactMap {
                    guard let rate = Rate(rawValue: $0.key) else { return nil}

                    return (rate, $0.value)
                }

                self?.rates = rates
            case .failure(_):
                self?.rates = nil
                break
            }
        }
    }
}
