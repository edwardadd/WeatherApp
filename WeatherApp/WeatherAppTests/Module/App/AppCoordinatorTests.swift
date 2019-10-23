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
}
