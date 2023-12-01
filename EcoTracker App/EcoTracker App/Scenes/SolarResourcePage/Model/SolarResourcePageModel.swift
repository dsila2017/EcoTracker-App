//
//  Model.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation

struct SolarResourceResponse: Decodable {
    let outputs: Outputs
}

struct Outputs: Decodable {
    let avgDni, avgGhi, avgLatTilt: Avg

    enum CodingKeys: String, CodingKey {
        case avgDni = "avg_dni"
        case avgGhi = "avg_ghi"
        case avgLatTilt = "avg_lat_tilt"
    }
}

struct Avg: Decodable {
    let annual: Double
    let monthly: [String: Double]
}
