//
//  ViewController+Extensions.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    @objc func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
