//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

protocol SpeciePageViewModelDelegate: AnyObject {
    func cityFetched(_ city: City)
    func showError(_ error: Error)
}

final class SpeciePageViewModel {
    private let network: Network
    private var city: City?

    weak var delegate: SpeciePageViewModelDelegate?
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func buttonTapped(for cityName: String) {
        fetchCityID(for: cityName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let city):
                self.delegate?.cityFetched(city)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
    
    private func fetchCityID(for cityName: String, completion: @escaping (Result<City, Error>) -> Void) {
        guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.inaturalist.org/v1/places/autocomplete?q=\(encodedCityName)") else {
            completion(.failure(NetworkError.data))
            return
        }
        
        network.request(with: url) { (result: Result<cityData, Error>) in
            switch result {
            case .success(let cities):
                if let firstCity = cities.results.first {
                    self.city = firstCity
                    self.delegate?.cityFetched(firstCity)
                } else {
                    completion(.failure(NetworkError.parse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
