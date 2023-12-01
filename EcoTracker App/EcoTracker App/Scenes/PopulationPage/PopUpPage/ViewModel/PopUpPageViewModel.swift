//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/30/23.
//

import Foundation
import NetworkManagerPro

protocol PopUpPageViewModelDelegate: AnyObject {
    func viewDidLoad(population: PopulationModel)
    func fetchData(population: PopulationModel)
}

class  PopUpPageViewModel: PopUpPageViewModelDelegate {
    
    weak var delegate: PopUpPageView?
    var country: String?
    
    init(country: String? = nil) {
        self.country = country
    }
    
    func viewDidLoad(population: PopulationModel) {
        fetchData(population: population)
    }
    
    func fetchData(population: PopulationModel) {
        let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/\(country!)/today-and-tomorrow/")
        Network().request(with: url!) { (result: Result<PopulationModel, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.delegate?.updateUI(updateModel: success)
                }
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
}
