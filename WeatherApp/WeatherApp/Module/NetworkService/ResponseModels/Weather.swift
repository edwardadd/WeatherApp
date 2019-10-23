//
//  Weather.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
struct Weather: Codable, Equatable {
    let name: String
    let id: Int
    let wind: Wind
    let weather: [Weather]

    init(name: String) {
        self.id = 0
        self.name = name
        self.wind = Wind(speed: 0, deg: 0)
        self.weather = []
    }

    struct Weather: Codable, Equatable {
        let description: String
    }

    struct Wind: Codable, Equatable {
        let speed: Float
        let deg: Float
    }
}
