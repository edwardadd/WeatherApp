//
//  Weather.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation

struct Weather: Codable, Equatable {
    let name: String
    let wind: Wind
    let weather: [Weather]

    init(name: String) {
        self.name = name
        self.wind = Wind(speed: 0)
        self.weather = []
    }

    struct Weather: Codable, Equatable {
        let description: String
    }

    struct Wind: Codable, Equatable {
        let speed: Float
    }
}
