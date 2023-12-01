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
    
    var delegate: PopUpPageView?
    
    func viewDidLoad(population: PopulationModel) {
        fetchData(population: population)
    }
    
    func fetchData(population: PopulationModel) {
        let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/Brazil/today-and-tomorrow/")
        Network().request(with: url!) { (result: Result<PopulationModel, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.delegate?.updateUI(updateModel: success)
                    print(success.totalPopulation.count)
                }
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
}
