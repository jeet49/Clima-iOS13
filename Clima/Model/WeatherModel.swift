//
//  WeatherModel.swift
//  Clima
//
//  Created by Jeet Pujara on 1/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let sunrise: Double
    let sunset: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var feelsLikeString: String {
        return String(format: "%.0f", feelsLike)
    }
    
    var temperatureMinString: String {
        return String(format: "%.0f", tempMin)
    }
    
    var temperatureMaxString: String {
        return String(format: "%.0f", tempMax)
    }
    
    var sunriseConverted: String {
        getCommentTimeStamp(time: sunrise)
    }
    
    var sunsetConverted: String {
        getCommentTimeStamp(time: sunset)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...632:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func getCommentTimeStamp(time: Double) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
