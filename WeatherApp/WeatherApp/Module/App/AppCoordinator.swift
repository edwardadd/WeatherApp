//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit

class AppCoordinator {
    typealias API = WeatherFetchable

    var navigationController: UINavigationController?
    var networkService: API
    var storage: Storage

    init(navigationController: UINavigationController = UINavigationController(),
         networkService: API = NetworkService(key: "dae99d7ad1e9537e8e3c69b22a9182f6"),
         storage: Storage = CoreDataRepository.shared) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.storage = storage
    }

    func start() {
        showFavouriteList()
    }

    func showFavouriteList() {
        let storyboard = UIStoryboard(name: "FavouriteList", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? FavouriteListViewController else {
            fatalError("Could not find initial view controller")
        }
        let viewModel = FavouriteListViewModel(appCoordinator: self,
                                               networkService: networkService,
                                               storage: storage)
        viewController.viewModel = viewModel
        navigationController?.setViewControllers([viewController], animated: false)
    }

    func showAddFavourite() {
        let storyboard = UIStoryboard(name: "AddFavouriteViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? AddFavouriteViewController else {
            fatalError("Could not find initial view controller")
        }
        let viewModel = FavouriteViewModel(appCoordinator: self,
                                           networkService: networkService,
                                           storage: storage)
        viewController.viewModel = viewModel
        let newNavigationController = UINavigationController(rootViewController: viewController)
        navigationController?.present(newNavigationController, animated: true, completion: nil)
    }

    func refreshFavouritesList() {
        guard let favouriteListViewController = navigationController?.viewControllers.first as? FavouriteListViewController else { return }

        favouriteListViewController.viewModel?.refresh()
    }
}
