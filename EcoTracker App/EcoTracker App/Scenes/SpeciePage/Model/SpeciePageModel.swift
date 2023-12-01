//
//  Model.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation

struct cityData: Decodable {
    let results: [City]
}
struct City: Decodable {
    let id: Int
    let name: String
}

struct SpeciesResponse: Decodable {
    let results: [SpeciesInfo]
}

struct SpeciesInfo: Decodable {
    let taxon: TaxonInfo
}

struct TaxonInfo: Decodable {
    let name: String
    let defaultPhoto: PhotoInfo
    let wikipediaURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case defaultPhoto = "default_photo"
        case wikipediaURL = "wikipedia_url"
    }

}

struct PhotoInfo: Decodable {
    let attribution: String
    let url: String
}

