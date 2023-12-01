//
//  AirQualityPageViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

final class AirQualityPageViewModel {
    
    private let apiKey = "8167adb3-b95b-445e-b206-6e3b32f15db1"
    private let baseURL = "https://api.airvisual.com/v2/"
    
    private let network: NetworkService = Network()
    
    private weak var viewController: AirQualityPageViewController?
    
    private var fetchedCountries: [String]?
    
    init(viewController: AirQualityPageViewController) {
        self.viewController = viewController
    }
    
    func fetchCityData(for city: String, state: String, country: String) {
        let endpoint = "city"
        guard var components = URLComponents(string: baseURL + endpoint) else {
            handleError(with: "URL is wrong")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "city", value: city),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        guard let url = components.url else { return }
        
        network.request(with: url) { (result: Result<AirVisualResponse, Error>) in
            print("Did finish")
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.viewController?.showModel(response)
                    let iconName = response.data.current.weather.ic
                    let iconURL = "https://airvisual.com/images/" + iconName + ".png"
                    self.viewController?.updateImage(url: iconURL)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
        }
    }
    
    private func handleError(with message: String) {
        DispatchQueue.main.async {
            self.viewController?.handleError(with: message)
        }
    }
    
    func fetchCountries() {
        if let fetchedCountries {
            viewController?.updateCountries(fetchedCountries)
            return
        }
        
        let endpoint = "countries"
        
        guard var components = URLComponents(string: baseURL + endpoint) else {
            handleError(with: "URL is wrong")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        guard let url = components.url else {
            handleError(with: "URL was not created appropriatly")
            return
        }
        
        network.request(with: url) { (result: Result<CountriesResponse, Error>) in
            switch result {
            case .success(let countriesResponse):
                let countries = countriesResponse.data.map { $0.country }
                self.fetchedCountries = countries
                DispatchQueue.main.async {
                    self.viewController?.updateCountries(countries)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
        }
    }
    
    func fetchStates(in country: String) {
        let endpoint = "states"
        
        guard var components = URLComponents(string: baseURL + endpoint) else {
            handleError(with: "URL is wrong")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        guard let url = components.url else {
            handleError(with: "URL was not created appropriatly")
            return
        }
        
        network.request(with: url) { (result: Result<StatesResponse, Error>) in
            switch result {
            case .success(let statesResponse):
                let states = statesResponse.data.map { $0.state }
                DispatchQueue.main.async {
                    self.viewController?.updateStates(states)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
            
        }
    }
    
    func fetchCities(in country: String, state: String) {
        let endpoint = "cities"
        
        guard var components = URLComponents(string: baseURL + endpoint) else {
            handleError(with: "URL is wrong")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        guard let url = components.url else {
            handleError(with: "URL was not created appropriatly")
            return
        }
        
        network.request(with: url) { (result: Result<CitiesResponse, Error>) in
            switch result {
            case .success(let citiesResponse):
                let cities = citiesResponse.data.map { $0.city }
//                self.fetchedCountries = countries
                DispatchQueue.main.async {
                    self.viewController?.updateCities(cities)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
            
        }
    }
}
