//
//  RatesResponse.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct RatesResponse: Codable {
    var sucess: Bool?
    var timeStamp: Double?
    var base: String?
    var date: Date?
    var rates: Rates?
}
