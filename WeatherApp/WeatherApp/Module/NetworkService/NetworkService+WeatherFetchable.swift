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
}

extension NetworkService: WeatherFetchable {
    func fetch(city: String) -> AnyPublisher<Weather, Error> {
        let url = URL(string: "\(baseURL)weather?q=\(city)&APPID=\(key)")!
        print(url)
        let request = URLRequest(url: url)
        return perform(request)
    }
}
