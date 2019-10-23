//
//  FavouriteListTests.swift
//  WeatherAppTests
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import XCTest
import Combine
@testable import WeatherApp

class FavouriteListTests: XCTestCase {
    func testZeroFavourites() {
        // Given
        let mockNetworkService = MockNetworkService()
        let mockAppCoordinator = MockAppCoordinator()

        // When
        let viewModel = FavouriteListViewModel(appCoordinator: mockAppCoordinator,
                                               networkService: mockNetworkService)

        // Then
        XCTAssertEqual(viewModel.favourites.value, [])
    }

    func testShowEmptyButton() {
        // Given
        let mockNetworkService = MockNetworkService()
        let mockAppCoordinator = MockAppCoordinator()

        // When
        let viewModel = FavouriteListViewModel(appCoordinator: mockAppCoordinator,
                                               networkService: mockNetworkService)

        // Then
        XCTAssertTrue(viewModel.showEmptyAddButton)
    }

    func testShowFavourites() {
        // Given
        let mockNetworkService = MockNetworkService()
        let mockAppCoordinator = MockAppCoordinator()

        // When
        let viewModel = FavouriteListViewModel(appCoordinator: mockAppCoordinator,
                                               networkService: mockNetworkService)
        viewModel.favourites.value = [Favourite(name: "London")]

        // Then
        XCTAssertFalse(viewModel.showEmptyAddButton)
    }
}

extension FavouriteListTests {
    class MockAppCoordinator: AppCoordinator {
        override func start() {

        }
    }

    class MockNetworkService: WeatherFetchable {
        func fetch(city: String) -> AnyPublisher<Weather, Error> {
            return CurrentValueSubject<Weather, Error>(Weather(name: "London")).eraseToAnyPublisher()
        }
    }
}
