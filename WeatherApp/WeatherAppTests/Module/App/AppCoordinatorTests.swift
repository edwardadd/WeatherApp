//
//  AppCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import XCTest
@testable import WeatherApp

class AppCoordinatorTests: XCTestCase {
    func testInitialiseAppCoordinator() {
        XCTAssertNotNil(AppCoordinator().navigationController)
    }

    func testShowFavouriteListFirst() {
        // Given
        let coordinator = AppCoordinator()

        // When
        coordinator.start()

        // Then
        XCTAssert(coordinator.navigationController?.viewControllers.first is FavouriteListViewController)
    }

    func testShowAddFavourite() {
        // Given
        let coordinator = AppCoordinator()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = coordinator.navigationController

        // When
        coordinator.start()
        _ = coordinator.navigationController?.view
        coordinator.showAddFavourite()

        RunLoop.current.run(until: Date().addingTimeInterval(1))
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        RunLoop.current.run(until: Date().addingTimeInterval(1))

        // Then
        XCTAssert(coordinator.navigationController?.presentedViewController is AddFavouriteViewController)
    }
}
