//
//  Rates.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

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

    static let allRates: [Rate] = [.gbp, .eur, .jpy, .brl, .usd]
}
