//
//  Errors.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case malformedUrl
    case noResponse
    case parsingError
}
