//
//  Model.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation

struct WeatherForecastResponseModel: Decodable {
    let list: [WeatherDataModel]
    let city: CityModel
}

struct WeatherDataModel: Decodable {
    let main: MainWeatherDataModel
    let weather: [WeatherDescriptionDataModel]
    let wind: WindDataModel
}

struct MainWeatherDataModel: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherDescriptionDataModel: Decodable {
    let main: String
    let description: String
}

struct WindDataModel: Decodable {
    let speed: Double
    let deg: Int
}

struct CityModel: Decodable {
    let name: String
    let country: String
}
