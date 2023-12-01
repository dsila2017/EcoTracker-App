//
//  ViewModel.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Foundation
import NetworkManagerPro

protocol WeatherPageViewModelDelegate: AnyObject {
    func weatherDataResponseReceived(_ weatherData: WeatherForecastResponseModel)
    func showError(_ error: Error)
}

final class WeatherPageViewModel {
    private let networkManager: NetworkService
    weak var delegate: WeatherPageViewModelDelegate?
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast?"
    private let apiKey = "e77aed597a0d0d416f5a894cc977d3b2"
    
    // 41.6509502
    // 41.6360085
    
    init(networkManager: Network) {
        self.networkManager = networkManager
    }
    
    func getWeatherByCoordinates(lat: Double, lon: Double) {
        let urlString = "\(baseURL)lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        networkManager.request(with: url) { [weak self] (result: Result<WeatherForecastResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.weatherDataResponseReceived(response)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
