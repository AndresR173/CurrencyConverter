//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

struct Constants {

    static let API_ACCESS_KEY = "5cb21c23afd3660813fdf07fd8d96c74"

    struct Networking {

        static func getBaseURL() -> URL? {
            return URL(string: "http://data.fixer.io/api/")
        }

        struct Endpoint {
            static let LATEST = "latest"
        }

        struct QueryItems {
            static let BASE = "base"
            static let SYMBOLS = "smbols"
            static let ACCESS_KEY = "access_key"
        }
    }

}
