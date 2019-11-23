//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

protocol CurrencyConverterPresenterView: class {
    func didConvertRatesSuccess()
    func didConvertRatesFailure()
}

class CurrencyConverterPresenter {

    // MARK: - Properties

    typealias CurrencyRate = (Rate, Double)

    private weak var view: CurrencyConverterPresenterView?

    private var rates: [CurrencyRate]?

    // MARK: - LifeCycle

    init() {
        getRates()
    }

    // MARK: - Helpers

    func attachView(_ view: CurrencyConverterPresenterView?) {
        self.view = view
    }

    func didEnterValue(_ value: String) {

    }

    private func getRates(from: Rate = .usd) {

        let symbols: String = Rate.allRates.compactMap {
            if $0 != from {
                return $0.rawValue
            }
            return nil
        }.joined(separator: ",")

        ConverterRepository.getRates(from: from, to: symbols) { [weak self] result in
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
