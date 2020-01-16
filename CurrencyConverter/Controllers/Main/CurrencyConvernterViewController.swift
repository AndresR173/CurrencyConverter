//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit
import IntentsUI

class CurrencyConvernterViewController: BaseViewController<CurrencyConverterView> {

    // MARK: - Properties

    private lazy var usdIntent: CurrencyIntent = {
        let intent = CurrencyIntent()
        intent.from = "rate"
        intent.suggestedInvocationPhrase = "Get current rate"

        return intent
    }()

    private let presenter = CurrencyConverterPresenter()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)

        self.customView.textFieldHandler = { [weak self] text in
            self?.presenter.didEnterValue(text)
        }

        self.customView.indexChangeHandler = { [weak self] index in
            self?.presenter.updateRates(for: index)
        }

        presenter.updateRates(for: 0)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        customView.siriButton.delegate = self
        customView.siriButton.shortcut = INShortcut(intent: usdIntent)
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

// MARK: - INUIAddVoiceShortcutButtonDelegate

extension CurrencyConvernterViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }

}

// MARK: - INUIAddVoiceShortcutViewControllerDelegate

extension CurrencyConvernterViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}

// MARK: - INUIEditVoiceShortcutViewControllerDelegate

extension CurrencyConvernterViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
