//
//  AirQualityPageModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation

// MARK: - AirVisualResponse
struct AirVisualResponse: Decodable {
    let status: String
    let data: AirVisualData
}

// MARK: - AirVisualData
struct AirVisualData: Decodable {
    let city: String
    let state: String
    let country: String
    let location: AirVisualLocation
    let current: AirVisualCurrent
}

// MARK: - AirVisualLocation
struct AirVisualLocation: Decodable {
    let type: String
    let coordinates: [Double]
}

// MARK: - AirVisualCurrent
struct AirVisualCurrent: Decodable {
    let pollution: AirVisualPollution
    let weather: AirVisualWeather
}

// MARK: - AirVisualWeather
struct AirVisualWeather: Decodable {
    let ts: String
    let tp: Int
    let pr: Int
    let hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}

// MARK: - AirVisualPollution
struct AirVisualPollution: Decodable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}
