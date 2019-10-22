//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit

class AppCoordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        showFavouriteList()
    }

    func showFavouriteList() {
        let storyboard = UIStoryboard(name: "FavouriteList", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            fatalError("Could not find initial view controller")
        }
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
