//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct Constants {

    struct Networking {

        static func getBaseURL() -> URL? {
            return URL(string: "https://api.exchangerate-api.com")
        }

        struct Endpoint {
            static let LATEST = "v4/latest"
        }

        struct QueryItems {
            static let BASE = "base"
            static let SYMBOLS = "symbols"
            static let ACCESS_KEY = "access_key"
        }
    }

}
