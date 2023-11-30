//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

protocol SolarResourcePageViewModelDelegate: AnyObject {
    func solarResourceInfoGot(_ solarInfo: Outputs)
    func shoeError(_ error: Error)
}

final class SolarResourcePageViewModel {
    private let networkManager: NetworkService
    weak var delegate: SolarResourcePageViewModelDelegate?
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func viewDidLoad(address: String) {
        getCoordinatesByAddress(address)
    }
    
    private func getCoordinatesByAddress(_ address: String) {
        let url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?api_key=OZGqIgVGZgwGNxXPPfEylQYUXdx0K2Wu67xP2nw7&address=\(address)"
        
        guard let urlString = URL(string: url) else {
            return
        }
        
        networkManager.request(with: urlString) { [weak self] (result: Result<SolarResourceResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.solarResourceInfoGot(response.outputs)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
