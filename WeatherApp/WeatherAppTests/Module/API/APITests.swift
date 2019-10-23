//
//  APITests.swift
//  WeatherAppTests
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import XCTest
import Combine
@testable import WeatherApp

class APITests: XCTestCase {

    // Note: This end to end test should only be enable for testing
    func testFetchWeatherForCity() {
        let exp = expectation(description: "Wait for async end to end test to return")

        // Given
        let api = NetworkService(key: "dae99d7ad1e9537e8e3c69b22a9182f6")

        // When
        // Note: Without this local variable the whole chain is dealocated and fails
        let cancelable = api.fetch(city: "London")
            .sink(receiveCompletion: { failure in
                switch failure {
                case .finished:
                    break
                case let .failure(error):
                    if let decodeError = error as? DecodingError {
                        print(decodeError.failureReason)
                    }
                    XCTFail("\(error.localizedDescription)")
                }
            exp.fulfill()
        }, receiveValue: { weather in
            // Then
            let expected = Weather(name: "London")
            XCTAssertEqual(expected.name, weather.name)
        })

        wait(for: [exp], timeout: 10)
    }

    func testFetchWeatherForecastForCity() {
        let exp = expectation(description: "Wait for async end to end test to return")

        // Given
        let api = NetworkService(key: "dae99d7ad1e9537e8e3c69b22a9182f6")

        // When
        // Note: Without this local variable the whole chain is dealocated and fails
        let cancelable = api.fetchForecast(city: "London")
            .sink(receiveCompletion: { failure in
                switch failure {
                case .finished:
                    break
                case let .failure(error):
                    if let decodeError = error as? DecodingError {
                        print(decodeError.localizedDescription)
                    }
                    XCTFail("\(error.localizedDescription)")
                }
                exp.fulfill()
            }, receiveValue: { weather in
                // Then
                XCTAssertEqual(weather.city.name, "London")
            })

        wait(for: [exp], timeout: 10)
    }

    func testFetchWeatherForManyCities() {
        let exp = expectation(description: "Wait for async end to end test to return")

        // Given
        let api = NetworkService(key: "dae99d7ad1e9537e8e3c69b22a9182f6")

        // When
        // Note: Without this local variable the whole chain is dealocated and fails
        let cancelable = api.fetchMany(cities: [2643743, 6324729])
            .sink(receiveCompletion: { failure in
                switch failure {
                case .finished:
                    break
                case let .failure(error):
                    if let decodeError = error as? DecodingError {
                        print(decodeError.failureReason)
                    }
                    XCTFail("\(error.localizedDescription)")
                }
                exp.fulfill()
            }, receiveValue: { weather in
                // Then
                XCTAssertEqual("London", weather.list[0].name)
                XCTAssertEqual("Halifax", weather.list[1].name)
            })

        wait(for: [exp], timeout: 10)
    }
}
