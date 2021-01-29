//
//  Weather.swift
//  Clima
//
//  Created by Jeet Pujara on 1/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d93022a6116e137cb9dea2b5ea8744ff&units=metric"
    
    func fetchWeather(cityName: String) {
        let URL = weatherURL + "&q=\(cityName)"
        request(URLString: URL)
    }
    
    func fetchWeatherUsingLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let URL = weatherURL + "&lat=\(latitude)&lon=\(longitude)"
        request(URLString: URL)
    }
    
    func request(URLString: String) {
        if let url = URL(string: URLString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFail(withError: error)
                }
                
                if let data = data {
                    if let weather = self.parseJSON(data: data) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let feelsLike = decodedData.main.feels_like
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, sunrise: sunrise, sunset: sunset)
            return weather
        } catch {
            delegate?.didFail(withError: error)
            return nil
        }
    }
}
