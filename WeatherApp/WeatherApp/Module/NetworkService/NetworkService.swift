//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import Combine

class NetworkService {
    let key: String
    let urlSession: URLSession
    let baseURL = "https://api.openweathermap.org/data/2.5/"

    init(key: String, urlSession: URLSession = URLSession.shared) {
        self.key = key
        self.urlSession = urlSession
    }

    func perform<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let jsonDecoder = JSONDecoder()
        return urlSession.dataTaskPublisher(for: request)
            .map { result in
                if let response = result.response as? HTTPURLResponse {
                    print(response)
                }
                return result.data
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
