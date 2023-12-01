//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

protocol PopulationPageViewModelDelegate: AnyObject {
    func viewDidLoad(countries: CountriesModel)
    func fetchData(countries: CountriesModel)
}

class PopulationPageViewModel: PopulationPageViewModelDelegate {
    
    var delegate: PopulationPageViewController?
    
    func viewDidLoad(countries: CountriesModel) {
        fetchData(countries: countries)
    }
    
    func fetchData(countries: CountriesModel) {
        let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/countries")
        Network().request(with: url!) { (result: Result<CountriesModel, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.delegate?.pickerData = success
                    self.delegate?.mainPicker.reloadAllComponents()
                }
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
}
