//
//  RatesResponse.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct RatesResponse: Codable {
    var base: String?
    var date: Date?
    var rates: [String: Double]
}
