//
//  CitiesResponse.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import Foundation

struct CitiesResponse: Decodable {
    let status: String
    let data: [City]
    
    struct City: Decodable {
        let city: String
    }
}
