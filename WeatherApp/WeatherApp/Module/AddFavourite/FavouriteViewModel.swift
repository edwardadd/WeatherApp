//
//  FavouriteViewModel.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import UIKit
import Combine

struct DetailedWeather {

    let name: String
    let cityId: Int
    let windSpeed: String
    let weatherDescription: String

    init(response: Weather) {
        name = response.name
        cityId = response.id
        windSpeed = "Wind: \(response.wind.speed) m/s"
        weatherDescription = response.weather.first?.description ?? ""
    }
}

class FavouriteViewModel {

    weak var appCoordinator: AppCoordinator?
    weak var networkService: WeatherFetchable?
    weak var storage: Storage?

    var weather: CurrentValueSubject<DetailedWeather?, Error>
    var cancelable: AnyCancellable?

    init(appCoordinator: AppCoordinator,
         networkService: WeatherFetchable,
         storage: Storage) {
        self.appCoordinator = appCoordinator
        self.networkService = networkService
        self.storage = storage

        weather = CurrentValueSubject<DetailedWeather?, Error>(nil)
    }

    func search(city: String) {
        cancelable?.cancel()
        cancelable = networkService?.fetch(city: city)
            .map { DetailedWeather(response: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { detailedWeather in
                self.weather.value = detailedWeather
            })
    }

    func save() {
        guard let storage = storage, let weather = weather.value else { return }
        let favourite = storage.createFavourite()
        favourite.cityId = Int32(weather.cityId)
        favourite.name = weather.name
        storage.save()
    }
}
