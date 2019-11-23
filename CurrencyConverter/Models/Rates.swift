//
//  Rates.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation
import UIKit

enum Rate: String {
    case cop = "COP"
    case mxn = "MXN"
    case usd = "USD"

    var name: String {
        switch self {
        case .cop:
            return NSLocalizedString("cop", comment: "")
        case .mxn:
            return NSLocalizedString("mxn", comment: "")
        case .usd:
            return NSLocalizedString("usd", comment: "")
        }
    }

    var color: UIColor {
        switch self {
        case .cop:
            return .systemRed
        case .mxn:
            return .systemBlue
        case .usd:
            return .systemGreen
        }
    }

    static let allRates: [Rate] = [.cop, .mxn, .usd]

    static let availableRates: [String] = Rate.allRates.map { $0.name }

}
