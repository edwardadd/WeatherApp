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
        let exp = expectation(description: "Update when favourites change")
        let subject = viewModel.favourites.sink(receiveCompletion: { _ in },
                                                receiveValue: { favourites in
            XCTAssertTrue(favourites.isEmpty)
            exp.fulfill()
        })

        wait(for: [exp], timeout: 10)
    }

    func testShowFavourites() {
        // Given
        let mockNetworkService = MockNetworkService()
        let mockAppCoordinator = MockAppCoordinator()

        // When
        let viewModel = FavouriteListViewModel(appCoordinator: mockAppCoordinator,
                                               networkService: mockNetworkService)

        let exp = expectation(description: "Update when favourites change")
        var count = 0
        let subject = viewModel.favourites.sink(receiveCompletion: { _ in
        }, receiveValue: { favourites in
            if count == 0 {
                XCTAssertTrue(favourites.isEmpty)
            } else {
                XCTAssertTrue(favourites.count > 0)
                exp.fulfill()
            }
            count += 1
        })

        viewModel.favourites.value = [Favourite(name: "London")]

        // Then
        wait(for: [exp], timeout: 10)
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
