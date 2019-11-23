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

    static func getRates(from base: Rate, completion: @escaping CompletionHandler )  {
        guard let url = URL(string: Constants.Networking.Endpoint.LATEST, relativeTo: Constants.Networking.getBaseURL()) else {
            completion(Result.failure(NetworkingError.malformedUrl))
            return
        }

        let finalURL = url.appendingPathComponent(base.rawValue)

        let task = URLSession.shared.dataTask(with: finalURL) { data, resp , error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Result.failure(error ?? NetworkingError.noResponse))
                }

                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.versionFormatter)

            do {
                let response = try decoder.decode(RatesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(response))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(NetworkingError.parsingError))
                }

                return
            }
        }

        task.resume()
    }
}
