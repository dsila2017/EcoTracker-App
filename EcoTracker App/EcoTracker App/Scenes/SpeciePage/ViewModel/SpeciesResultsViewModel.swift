//
//  SpeciesResultsViewModel.swift
//  EcoTracker App
//
//  Created by nika razmadze on 30.11.23.
//

import Foundation
import NetworkManagerPro

final class SpeciesResultsViewModel {
    private let network: Network

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchSpeciesInfo(for cityID: Int, completion: @escaping (Result<[SpeciesInfo], Error>) -> Void) {
        guard let url = URL(string: "https://api.inaturalist.org/v1/observations/species_counts?place_id=\(cityID)") else {
            completion(.failure(NetworkError.data))
            return
        }

        network.request(with: url) { (result: Result<SpeciesResponse, Error>) in
            switch result {
            case .success(let SpeciesResponse):
                completion(.success(SpeciesResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
