//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

protocol CurrencyConverterView: class {
    func didConvertRatesSuccess()
    func didConvertRatesFailure()
}

class CurrencyConverterPresenter {

    private weak var view: CurrencyConverterView?

    init( _ view: CurrencyConverterView?) {
        self.view = view

        getRates()
    }

    // MARK: - Helpers

    func didEnterValue(_ value: String) {

    }

    private func getRates(from: Rate = .usd) {

        let symbols: String = Rate.allRates.compactMap {
            if $0 != from {
                return $0.rawValue
            }
            return nil
        }.joined(separator: ",")

        ConverterRepository.getRates(from: from, to: symbols) { result in
            switch result {
            case .success(let response):
                let rates: [(Rate, Double)] = response.rates.compactMap {
                    guard let rate = Rate(rawValue: $0.key) else { return nil}

                    return (rate, $0.value)
                }

                dump(rates)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
