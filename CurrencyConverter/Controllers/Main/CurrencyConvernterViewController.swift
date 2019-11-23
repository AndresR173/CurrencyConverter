//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit

class CurrencyConvernterViewController: BaseViewController<CurrencyConverterView> {

    // MARK: - Properties

    private let presenter = CurrencyConverterPresenter()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)

        self.customView.textFieldHandler = { [weak self] text in
            self?.presenter.didEnterValue(text)
        }
    }

}

// MARK: - CurrencyPresenter Delegate

extension CurrencyConvernterViewController: CurrencyConverterPresenterView {
    func displayValues(_ values: [DataEntry], animated: Bool) {
        self.customView.updateDataEntries(values, animated: animated)
    }

    func didConvertRatesFailure() {

    }

}
