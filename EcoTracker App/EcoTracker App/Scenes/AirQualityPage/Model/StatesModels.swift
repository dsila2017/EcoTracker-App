//
//  StatesModels.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import Foundation

struct StatesResponse: Decodable {
    let status: String
    let data: [State]
    
    struct State: Decodable {
        let state: String
    }
}
