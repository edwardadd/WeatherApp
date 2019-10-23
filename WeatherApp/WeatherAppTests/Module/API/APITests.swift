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
                    XCTFail("\(error.localizedDescription)")
                }
            exp.fulfill()
        }, receiveValue: { weather in
            // Then
            let expected = Weather(name: "London")
            XCTAssertEqual(expected, weather)
        })

        wait(for: [exp], timeout: 10)
    }
}
