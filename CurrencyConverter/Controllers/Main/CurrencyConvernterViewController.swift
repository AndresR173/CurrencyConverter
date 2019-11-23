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

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Helpers
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - CurrencyPresenter Delegate

extension CurrencyConvernterViewController: CurrencyConverterPresenterView {
    func displayValues(_ values: [DataEntry], animated: Bool) {
        self.customView.updateDataEntries(values, animated: animated)
    }

}
