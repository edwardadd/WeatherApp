//
//  FavouriteViewModel.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import Combine

struct DetailedWeather {

}

struct FavouriteViewModel {

    weak var appCoordinator: AppCoordinator?
    weak var networkService: WeatherFetchable?

    var weather: CurrentValueSubject<DetailedWeather?, Error>

    init(appCoordinator: AppCoordinator, networkService: WeatherFetchable) {
        self.appCoordinator = appCoordinator
        self.networkService = networkService

        weather = CurrentValueSubject<DetailedWeather?, Error>(nil)
    }

    func search(city: String) {
    }
}
