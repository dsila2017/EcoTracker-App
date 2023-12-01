//
//  SolarResourcesAverageInfoViewController.swift
//  EcoTracker App
//
//  Created by Nika Jamatashvili on 01.12.23.
//

import UIKit

class SolarResourcesAverageInfoViewController: UIViewController {
    
    var avgDniValue: Double = 0.0
    var avgGhiValue: Double = 0.0
    var avgLatTiltValue: Double = 0.0
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.background
        title = "Solar Resource Information"
        
        setupCloseButton()
        setupUI()
        displaySolarResourceInfo()
    }
    
    private func setupUI() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addInformationToStackView(title: String, information: String, averageValue: Double) {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.text = "\(title):"
        
        let informationLabel = UILabel()
        informationLabel.textColor = UIColor.white.withAlphaComponent(0.60)
        informationLabel.font = UIFont.systemFont(ofSize: 16)
        informationLabel.numberOfLines = 0
        informationLabel.text = information
        
        let averageLabel = UILabel()
        averageLabel.textColor = UIColor.white
        averageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        averageLabel.numberOfLines = 0
        averageLabel.text = "\(averageValue)"
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.12)
        backgroundView.layer.cornerRadius = 8
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(informationLabel)
        backgroundView.addSubview(averageLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        averageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            
            informationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            informationLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            informationLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            
            averageLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 8),
            averageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            averageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            averageLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -12)
        ])
    }
    
    private func displaySolarResourceInfo() {
        addInformationToStackView(
            title: "Direct Normal Irradiance (DNI)",
            information: "DNI represents the amount of solar radiation received per unit area by a surface that is always held perpendicular to the rays that come in a straight line from the direction of the sun.",
            averageValue: avgDniValue
        )
        
        addInformationToStackView(
            title: "Global Horizontal Irradiance (GHI)",
            information: "GHI measures the total amount of shortwave radiation received from above by a horizontal surface.",
            averageValue: avgGhiValue
        )
        
        addInformationToStackView(
            title: "Latitude Tilt",
            information: "Latitude tilt refers to the optimal angle at which solar panels should be installed to maximize energy production based on the location's latitude.",
            averageValue: avgLatTiltValue
        )
        
        if avgDniValue >= 5.0 && avgGhiValue >= 5.5 && avgLatTiltValue >= 5.0 {
            displayPlaceStatus(status: "good", color: UIColor.green.withAlphaComponent(0.60))
        } else {
            displayPlaceStatus(status: "bad", color: UIColor.red)
        }
    }
    
    private func displayPlaceStatus(status: String, color: UIColor) {
        let statusLabel = UILabel()
        statusLabel.textColor = color
        statusLabel.font = UIFont.boldSystemFont(ofSize: 18)
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        
        if status == "good" {
            statusLabel.text = "This is a good place for solar energy!"
        } else {
            statusLabel.text = "This is a bad place for solar energy!"
            statusLabel.textColor = UIColor.red.withAlphaComponent(0.60)
        }
        
        stackView.addArrangedSubview(statusLabel)
        
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
