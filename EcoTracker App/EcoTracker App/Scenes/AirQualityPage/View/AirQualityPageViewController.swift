//
//  AirQualityPageViewController.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import Kingfisher
import UIKit
import MapKit

final class AirQualityPageViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var cityTextField: UITextField = {
        let textField = EcoTextField()
        textField.setPlaceholder("Choose City")
        textField.delegate = self
        return textField
    }()
    
    private lazy var stateTextField: UITextField = {
        let textField = EcoTextField()
        textField.setPlaceholder("Choose State")
        textField.delegate = self
        return textField
    }()
    
    private lazy var countryTextField: UITextField = {
        let textField = EcoTextField()
        textField.setPlaceholder("Choose Country")
        textField.delegate = self
        return textField
    }()
    
    private lazy var fetchDataButton: UIButton = {
        let button = EcoButton()
        button.setTitle("Fetch Data", for: .normal)
        button.addOnTouchUpInsideAction(fetchDataButtonTapped)
        return button
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 12
        mapView.isHidden = true
        return mapView
    }()
    
    private let airQualityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .primary
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    // MARK: - Properties
    private lazy var viewModel = AirQualityPageViewModel(delegate: self)
    
    private var selectedCountry: String?
    private var selectedState: String?
    private var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(countryTextField)
        mainStackView.addArrangedSubview(stateTextField)
        mainStackView.addArrangedSubview(cityTextField)
        
        mainStackView.addArrangedSubview(fetchDataButton)
        mainStackView.addArrangedSubview(mapView)
            
        
        let stackView = UIStackView(arrangedSubviews: [airQualityLabel, imageView])
        stackView.spacing = 16
        stackView.alignment = .center
        mainStackView.addArrangedSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            mapView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func fetchDataButtonTapped() {
        guard let city = cityTextField.text, !city.isEmpty,
              let state = stateTextField.text, !state.isEmpty,
              let country = countryTextField.text, !country.isEmpty
        else {
            handleError(with: "All fields should be non-empty")
            return
        }
        
        viewModel.fetchCityData(for: city, state: state, country: country)
    }
    
    private func showAlert(title: String, message: String) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "Okay", style: .default))
        present(viewController, animated: true)
    }
}

// MARK: - AirQualityPageViewModelDelegate
extension AirQualityPageViewController: AirQualityPageViewModelDelegate {
    
    func updateCountries(_ countries: [String]) {
        let viewController = PickerViewController(countries, for: .country)
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    func updateStates(_ states: [String]) {
        let viewController = PickerViewController(states, for: .state)
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    func updateCities(_ cities: [String]) {
        let viewController = PickerViewController(cities, for: .city)
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    func updateImage(url urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
    
    func showModel(_ model: AirVisualResponse) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            mapView.isHidden = false
            
            self.cityTextField.text = model.data.city
            self.stateTextField.text = model.data.state
            self.countryTextField.text = model.data.country
            
            let airQualityText = 
"""
Weather: \(model.data.current.weather.ic)
Temperature: \(model.data.current.weather.tp) °C
Humidity: \(model.data.current.weather.hu)%
Wind Speed: \(model.data.current.weather.ws) m/s
Air Quality Index (US): \(model.data.current.pollution.aqius)
Air Quality Index (China): \(model.data.current.pollution.aqicn)
"""
            self.airQualityLabel.text = airQualityText
            
            let coordinates = CLLocationCoordinate2D(
                latitude: model.data.location.coordinates[1],
                longitude: model.data.location.coordinates[0]
            )
            let region = MKCoordinateRegion(
                center: coordinates,
                latitudinalMeters: 35000,
                longitudinalMeters: 35000
            )
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func handleError(with message: String) {
        showAlert(title: "Error", message: message)
    }
}

extension AirQualityPageViewController: PickerDelegate {
    func didSelect(to item: String, for type: PickerType) {
        switch type {
        case .country:
            countryTextField.text = item
            stateTextField.text = ""
            cityTextField.text = ""
        case .state:
            stateTextField.text = item
            cityTextField.text = ""
        case .city:
            cityTextField.text = item
        }
    }
}

extension AirQualityPageViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case countryTextField:
            viewModel.fetchCountries()
        case stateTextField:
            guard let country = countryTextField.text, !country.isEmpty else {
                handleError(with: "Please choose country first")
                return false
            }
            
            viewModel.fetchStates(in: country)
        case cityTextField:
            guard let country = countryTextField.text, !country.isEmpty,
                  let state = stateTextField.text, !state.isEmpty
            else {
                handleError(with: "Please choose country and state first")
                return false
            }
            
            viewModel.fetchCities(in: country, state: state)
        default:
            break
        }
        
        return false
    }
}
