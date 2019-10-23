# WeatherApp

Allows the user to see the wind and weather conditions for favourited locations.

## Goals

* MVVM-C Architecture
* Combine framework

## Motivation

This tech test has been a learning experience. The idea was to learn to use Combine instead of RxSwift in a non SwiftUI setting. As with all tests there is a time limit. I focused more on the architectural and functional side of the project which means the design of the app has suffered somewhat.

## Issues

* Error handling requires more work
* Loading states are missing
* Forecast data isn't cached
* Weather isn't shown on the favourites list
* Only the minimal weather data is used
* There is more room for even more tests

## What to do next time?

* Trying something new meant there was times where I was stumped. For instance streams are deallocated if they are kept locally or in an AnyCancellable store.
* Starting off with testing and as time passed moving into a more hastey state. Forgetting the tests and focusing on developing quicker instead.
* I misunderstood the requirement about the weather forecast and nearly missed it.