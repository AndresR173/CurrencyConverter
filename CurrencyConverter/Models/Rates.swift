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
    case eur = "EUR"
    case gbp = "GBP"
    case jpy = "JPY"
    case brl = "BRL"
    case usd = "USD"

    var name: String {
        switch self {
        case .eur:
            return "EU Euro"
        case .gbp:
            return "UK Pounds"
        case .jpy:
            return "Japan Yen"
        case .brl:
            return "Brazil Reais"
        case .usd:
            return "US Dollar"
        }
    }

    var color: UIColor {
        switch self {
        case .eur:
            return .systemRed
        case .gbp:
            return .systemBlue
        case .jpy:
            return .systemOrange
        case .brl:
            return .systemYellow
        case .usd:
            return .systemGreen
        }
    }

    static let allRates: [Rate] = [.gbp, .eur, .jpy, .brl, .usd]
}
