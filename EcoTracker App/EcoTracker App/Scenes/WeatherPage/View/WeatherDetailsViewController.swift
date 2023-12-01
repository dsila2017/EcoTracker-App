//
//  WeatherDetailsViewController.swift
//  EcoTracker App
//
//  Created by Macbook Air 13 on 01.12.23.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 50, left: 20, bottom: 20, right: 20)
        stackView.axis = .vertical
        stackView.spacing = 50
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 16
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 70.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let minAndMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let additionalDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = CustomColors.primary.withAlphaComponent(0.1)
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private let additionalDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        label.textColor = CustomColors.white
        label.text = "Additional Data:"
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.backgroundColor = CustomColors.primary.withAlphaComponent(0.1)
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private let windIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(systemName: "wind")
        imageView.tintColor = CustomColors.white
        return imageView
    }()
    
    private let windDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private let windDirectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = CustomColors.white
        return label
    }()
    
    private var weatherResponse: WeatherForecastResponseModel?
    

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Configure
    func setupWeatherData(for weatherResponse: WeatherForecastResponseModel) {
        self.weatherResponse = weatherResponse
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = CustomColors.background
        setupMainStackView()
        fillMainStackView()
        fillTitleStackView()
        fillAdditionalDataStackView()
        fillWindStackView()
        fillWindDataStackView()
        presentWeatherData()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        setMainStackViewConstraints()
    }
    
    private func fillMainStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(additionalDataStackView)
        mainStackView.setCustomSpacing(15.0, after: additionalDataStackView)
        mainStackView.addArrangedSubview(windStackView)
    }
    
    private func fillTitleStackView() {
        titleStackView.addArrangedSubview(cityLabel)
        titleStackView.addArrangedSubview(temperatureLabel)
        titleStackView.addArrangedSubview(weatherDescriptionLabel)
        titleStackView.addArrangedSubview(minAndMaxTemperatureLabel)
    }
    
    private func fillAdditionalDataStackView() {
        additionalDataStackView.addArrangedSubview(additionalDetailsLabel)
        additionalDataStackView.addArrangedSubview(feelsLikeLabel)
        additionalDataStackView.addArrangedSubview(pressureLabel)
        additionalDataStackView.addArrangedSubview(humidityLabel)
    }
    
    private func fillWindStackView() {
        windStackView.addArrangedSubview(windIconImageView)
        windStackView.addArrangedSubview(windDataStackView)
    }
    
    private func fillWindDataStackView() {
        windDataStackView.addArrangedSubview(windSpeedLabel)
        windDataStackView.addArrangedSubview(windDirectionLabel)
    }
    
    private func presentWeatherData() {
        cityLabel.text = "\(weatherResponse?.city.name ?? ""), \(weatherResponse?.city.country ?? "")"
        temperatureLabel.text = "\(weatherResponse?.list[0].main.temp ?? 0)º"
        weatherDescriptionLabel.text = weatherResponse?.list[0].weather[0].description
        minAndMaxTemperatureLabel.text = "H:\(weatherResponse?.list[0].main.tempMax ?? 0)º   L: \(weatherResponse?.list[0].main.tempMin ?? 0)º"
        
        feelsLikeLabel.text = "Feels like: \(weatherResponse?.list[0].main.feelsLike ?? 0)º"
        pressureLabel.text = "Pressure: \(weatherResponse?.list[0].main.pressure ?? 0)º"
        humidityLabel.text = "Humidity: \(weatherResponse?.list[0].main.humidity ?? 0)º"
        
        windSpeedLabel.text = "Speed: \(weatherResponse?.list[0].wind.speed ?? 0) m/s"
        windDirectionLabel.text = "Direction: \(weatherResponse?.list[0].wind.deg ?? 0)º"
    }
    
    
    // MARK: - Constraints
    private func setMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
