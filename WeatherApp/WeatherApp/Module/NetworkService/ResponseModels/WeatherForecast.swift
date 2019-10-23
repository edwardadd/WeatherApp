//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
struct WeatherForecast: Codable, Equatable {
    let city: City
    let list: [Weather]

    struct City: Codable, Equatable {
        let id: Int
        let name: String
    }

    struct Weather: Codable, Equatable {
        let dt: Int
        let wind: Wind
    }

    struct Wind: Codable, Equatable {
        let speed: Float
        let deg: Float
    }
}
