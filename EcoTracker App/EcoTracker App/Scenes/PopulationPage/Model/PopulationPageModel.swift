//
//  Model.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation

struct PopulationModel: Codable {
    let totalPopulation: [TotalPopulation]

    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}

// MARK: - TotalPopulation
struct TotalPopulation: Codable {
    let date, population: String
}
