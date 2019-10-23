//
//  FavouriteListTests.swift
//  WeatherAppTests
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import XCTest
import CoreData
import Combine
@testable import WeatherApp

class FavouriteListTests: XCTestCase {
    let mockNetworkService = MockNetworkService()
    let mockAppCoordinator = MockAppCoordinator()
    let mockStorage = MockStorage()

    var viewModel: FavouriteListViewModel!

    override func setUp() {
        viewModel = FavouriteListViewModel(appCoordinator: mockAppCoordinator,
                                           networkService: mockNetworkService,
                                           storage: mockStorage)
    }

    func testZeroFavourites() {
        XCTAssertEqual(viewModel.favourites.value, [])
    }

    func testShowEmptyButton() {
        let exp = expectation(description: "Update when favourites change")
        let subject = viewModel.favourites.sink(receiveCompletion: { _ in },
                                                receiveValue: { favourites in
            XCTAssertTrue(favourites.isEmpty)
            exp.fulfill()
        })

        wait(for: [exp], timeout: 10)
    }

    func testShowFavourites() {
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

        let newValue = Favourite()
        viewModel.favourites.value = [newValue]

        wait(for: [exp], timeout: 10)
    }
}

extension FavouriteListTests {
    class MockAppCoordinator: AppCoordinator {
        override func start() {

        }
    }

    class MockNetworkService: WeatherFetchable {
        func fetchForecast(city: String) -> AnyPublisher<WeatherForecast, Error> {
            let forecast = WeatherForecast(city: WeatherForecast.City(id: 0, name: ""), list: [])
            return CurrentValueSubject<WeatherForecast, Error>(forecast).eraseToAnyPublisher()
        }

        func fetch(city: String) -> AnyPublisher<Weather, Error> {
            return CurrentValueSubject<Weather, Error>(Weather(name: "London")).eraseToAnyPublisher()
        }
    }

    class MockStorage: Storage {
        var poc: NSPersistentContainer

        init() {
            poc = NSPersistentContainer(name: "Model")
        }

        func save() { }
    }
}
