//
//  NetworkService+WeatherFetchable.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import Combine

protocol WeatherFetchable: class {
    func fetch(city: String) -> AnyPublisher<Weather, Error>
    func fetchForecast(city: String) -> AnyPublisher<WeatherForecast, Error>
}

extension NetworkService: WeatherFetchable {
    func fetch(city: String) -> AnyPublisher<Weather, Error> {
        let url = URL(string: "\(baseURL)weather?q=\(city)&APPID=\(key)")!
        print(url)
        let request = URLRequest(url: url)
        return perform(request)
    }

    func fetchForecast(city: String) -> AnyPublisher<WeatherForecast, Error> {
        let url = URL(string: "\(baseURL)forecast?q=\(city)&APPID=\(key)")!
        print(url)
        let request = URLRequest(url: url)
        return perform(request)
    }

    func fetchMany(cities: [Int]) -> AnyPublisher<BulkWeather, Error> {
        var list: String = cities.reduce("") { result, cityId -> String in
            return result + "\(cityId),"
        }
        if list.hasSuffix(",") {
            list.removeLast(1)
        }

        let url = URL(string: "\(baseURL)group?id=\(list)&APPID=\(key)")!
        print(url)
        let request = URLRequest(url: url)
        return perform(request)
    }
}
