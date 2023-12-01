//
//  CountryModels.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 30.11.23.
//

import Foundation

struct CountriesResponse: Decodable {
    let status: String
    let data: [Country]
    
    struct Country: Decodable {
        let country: String
    }
}
