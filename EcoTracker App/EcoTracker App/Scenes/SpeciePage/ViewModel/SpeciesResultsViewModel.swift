//
//  SpeciesResultsViewModel.swift
//  EcoTracker App
//
//  Created by nika razmadze on 30.11.23.
//

import Foundation
import NetworkManagerPro

protocol SpeciesResultViewDelegate: AnyObject {
    func speciesFetched(_ species: [SpeciesInfo])
    func showError(_ error: Error)
}

final class SpeciesResultsViewModel {
    private let network: Network
    private var species: [SpeciesInfo]?
    
    weak var delegate: SpeciesResultViewDelegate?
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func viewDidLoad(for cityID: Int) {
        fetchSpeciesInfo(for: cityID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let species):
                self.species = species
                self.delegate?.speciesFetched(species)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }

    private func fetchSpeciesInfo(for cityID: Int, completion: @escaping (Result<[SpeciesInfo], Error>) -> Void) {
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
