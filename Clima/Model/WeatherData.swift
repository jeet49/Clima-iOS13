//
//  WeatherData.swift
//  Clima
//
//  Created by Jeet Pujara on 1/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: System
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct System: Codable {
    let sunrise: Double
    let sunset: Double
}

