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
    weak var storage: Storage?

    var favourites: CurrentValueSubject<[Favourite], Error>

    init(appCoordinator: AppCoordinator,
         networkService: WeatherFetchable,
         storage: Storage) {
        self.appCoordinator = appCoordinator
        self.networkService = networkService
        self.storage = storage

        let list = storage.fetchFavouriteList()
        favourites = CurrentValueSubject<[Favourite], Error>(list)
    }

    func refresh() {
        guard let storage = storage else { return }
        favourites.value = storage.fetchFavouriteList()
    }

    func shouldShowAddFavourite() {
        appCoordinator?.showAddFavourite()
    }

    func delete(favourite: Int) {
    }
}
