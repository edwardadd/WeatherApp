//
//  FavouriteListViewModel.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import Combine

struct FavouriteListViewModel {
    weak var appCoordinator: AppCoordinator?
    weak var networkService: WeatherFetchable?

    var favourites: CurrentValueSubject<[Favourite], Error>

    init(appCoordinator: AppCoordinator, networkService: WeatherFetchable) {
        self.appCoordinator = appCoordinator
        self.networkService = networkService

        // TODO Load list of favourites and load their data
        favourites = CurrentValueSubject<[Favourite], Error>([])
    }

    func shouldShowAddFavourite() {

    }

    func delete(favourite: Int) {

    }
}
