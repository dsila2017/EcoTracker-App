//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

final class SpeciePageViewModel {
    private let network: Network

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchCityID(for cityName: String, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.inaturalist.org/v1/places/autocomplete?q=\(encodedCityName)") else {
            completion(.failure(NetworkError.data))
            return
        }
        
        network.request(with: url) { (result: Result<cityData, Error>) in
            switch result {
            case .success(let cities):
                if let firstCity = cities.results.first {
                    completion(.success(firstCity.id))
                } else {
                    completion(.failure(NetworkError.parse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
