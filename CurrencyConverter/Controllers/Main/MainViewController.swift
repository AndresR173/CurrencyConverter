//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties

    private lazy var presenter: CurrencyConverterPresenter = {
        return CurrencyConverterPresenter(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.didEnterValue("2")
    }


}

extension MainViewController: CurrencyConverterView {
    func didConvertRatesSuccess() {

    }

    func didConvertRatesFailure() {

    }

}
