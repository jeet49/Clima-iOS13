//
//  Protocols.swift
//  Clima
//
//  Created by Jeet Pujara on 1/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFail(withError error: Error)
}
