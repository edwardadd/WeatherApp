//
//  BulkWeather.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation

struct BulkWeather: Codable, Equatable {
    let cnt: Int
    let list: [Weather]

    struct Weather: Codable, Equatable {
        let id: Int
        let name: String
        let wind: Wind
    }

    struct Wind: Codable, Equatable {
        let speed: Float
        let deg: Float
    }
}
