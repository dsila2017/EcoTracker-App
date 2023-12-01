//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

protocol PopulationPageViewModelDelegate: AnyObject {
    func fetchData(countries: CountriesModel)
    func showError(_ error: Error)
}

protocol PopulationPageViewModelProtocol {
    var delegate: PopulationPageViewModelDelegate? { get set }
    func viewDidLoad(countries: CountriesModel)
}

final class PopulationPageViewModel: PopulationPageViewModelProtocol {
    
    weak var delegate: PopulationPageViewModelDelegate?
    
    func viewDidLoad(countries: CountriesModel) {
        fetchData(countries: countries)
    }
    
    func fetchData(countries: CountriesModel) {
        let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/countries")
        Network().request(with: url!) { (result: Result<CountriesModel, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.delegate?.fetchData(countries: success)
                }
            case .failure(let failure):
                self.delegate?.showError(failure)
                break
            }
        }
    }
}
