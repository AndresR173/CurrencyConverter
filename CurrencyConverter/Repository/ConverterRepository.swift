//
//  ConverterRepository.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import Foundation

class ConverterRepository {

    typealias CompletionHandler = ((Result<RatesResponse, Error>) -> Void)

    static func getRates(from base: Rate, to symbols: String, completion: @escaping CompletionHandler )  {
        guard let url = URL(string: Constants.Networking.Endpoint.LATEST, relativeTo: Constants.Networking.getBaseURL()),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(NetworkingError.malformedUrl))
            return
        }

        components.queryItems = [
            URLQueryItem(name: Constants.Networking.QueryItems.ACCESS_KEY, value: Constants.API_ACCESS_KEY),
            URLQueryItem(name: Constants.Networking.QueryItems.BASE, value: base.rawValue),
            URLQueryItem(name: Constants.Networking.QueryItems.SYMBOLS, value: symbols)
        ]

        guard let finalURL = components.url else {
            completion(Result.failure(NetworkingError.malformedUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            guard let data = data else {
                completion(Result.failure(error ?? NetworkingError.noResponse))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.versionFormatter)

            do {
                let response = try decoder.decode(RatesResponse.self, from: data)

                completion(Result.success(response))
            } catch {
                completion(Result.failure(NetworkingError.parsingError))
                return
            }
        }

        task.resume()

        completion(Result.success(RatesResponse()))
    }
}
