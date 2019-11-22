//
//  Rates.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct Rates: Codable {

    var eur: Double?
    var gbp: Double?
    var jpy: Double?
    var brl: Double?
    var usd: Double?

    private enum CodingKeys: String, CodingKey {
        case eur = "EUR"
        case gbp = "GBP"
        case jpy = "JPY"
        case usd = "USD"
    }
}

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

    var allRates: [Rate] {
        return [.gbp, .eur, .jpy, .brl, .usd]
    }
}
