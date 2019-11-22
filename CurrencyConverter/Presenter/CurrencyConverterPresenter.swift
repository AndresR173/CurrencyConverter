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
    }
}
