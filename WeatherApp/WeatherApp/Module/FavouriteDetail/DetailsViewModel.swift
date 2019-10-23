//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import UIKit
import Combine

struct Details {
    let date: String
    let windDescription: String

    init(response: WeatherForecast.Weather) {
        let responseDate = Date(timeIntervalSince1970: TimeInterval(response.dt))
        let requiredFormat = "E d MMM yyyy, h:mma"
        let formatter = DateFormatter()
        formatter.dateFormat = requiredFormat
        formatter.locale = Calendar.current.locale
        date =  formatter.string(from: responseDate)
        windDescription = "\(response.wind.speed) m/s"
    }
}

class DetailsViewModel {
    weak var appCoordinator: AppCoordinator?
    weak var networkService: WeatherFetchable?

    var details: CurrentValueSubject<[Details], Error> = .init([])

    private var cancelable: AnyCancellable?

    init(appCoordinator: AppCoordinator,
         networkService: WeatherFetchable,
         favourite: Favourite) {
        self.appCoordinator = appCoordinator
        self.networkService = networkService

        cancelable = networkService.fetchForecast(city: favourite.name)
            .map { forecast in
                forecast.list.map { Details(response: $0) }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { detailedWeather in
                self.details.value = detailedWeather
            })
    }
}
