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
            let rates = self.rates else { return }

        self.view?.displayValues(rates.getDataEntries(for: base, value: doubleValue), animated: true)
    }

    func updateRates(for index: Int) {
        guard  let rate = Rate.allRates.first(where: { $0.name == Rate.availableRates[index] }) else {
            return
        }

        base = rate

        getRates()
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
                self?.rates = response.rates.getRates()
                self?.didEnterValue(self?.lastValue)
            case .failure(_):
                self?.rates = nil
            }
        }
    }
}
