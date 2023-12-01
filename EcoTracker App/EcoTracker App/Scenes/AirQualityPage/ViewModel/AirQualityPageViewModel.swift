//
//  AirQualityPageViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

// MARK: - Delegate
protocol AirQualityPageViewModelDelegate: AnyObject {
    func updateCountries(_ countries: [String])
    func updateStates(_ states: [String])
    func updateCities(_ cities: [String])
    func updateImage(url urlString: String)
    func showModel(_ model: AirVisualResponse)
    func handleError(with message: String)
}

final class AirQualityPageViewModel {
    
    // MARK: - Properties
    private let apiKey = "8167adb3-b95b-445e-b206-6e3b32f15db1"
    private let baseURL = "https://api.airvisual.com/v2/"
    
    private let network: NetworkService = Network()
    
    weak var delegate: AirQualityPageViewController?
    
    private var fetchedCountries: [String]?
    
    init(delegate: AirQualityPageViewController) {
        self.delegate = delegate
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
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.delegate?.showModel(response)
                    let iconName = response.data.current.weather.ic
                    let iconURL = "https://airvisual.com/images/" + iconName + ".png"
                    self.delegate?.updateImage(url: iconURL)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
        }
    }
    
    private func handleError(with message: String) {
        DispatchQueue.main.async {
            self.delegate?.handleError(with: message)
        }
    }
    
    func fetchCountries() {
        if let fetchedCountries {
            delegate?.updateCountries(fetchedCountries)
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
                    self.delegate?.updateCountries(countries)
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
                    self.delegate?.updateStates(states)
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
                DispatchQueue.main.async {
                    self.delegate?.updateCities(cities)
                }
            case .failure(let error):
                self.handleError(with: error.localizedDescription)
            }
        }
    }
}
