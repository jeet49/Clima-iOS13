//
//  Weather.swift
//  Clima
//
//  Created by Jeet Pujara on 1/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d93022a6116e137cb9dea2b5ea8744ff&units=metric"
    
    func fetchWeather(cityName: String) {
        let URL = weatherURL + "&q=\(cityName)"
        request(URLString: URL)
    }
    
    func request(URLString: String) {
        if let url = URL(string: URLString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let data = data {
                    self.parseJSON(data: data)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            print(decodedData.main.temp)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
