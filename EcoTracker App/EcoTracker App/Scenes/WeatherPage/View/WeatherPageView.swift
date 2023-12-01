//
//  WeatherPage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import UIKit

final class WeatherPageViewController: UIViewController {

    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 46
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private let searchOptionsSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Coordinates", "City"])
        segmentedControl.selectedSegmentTintColor = CustomColors.darkGray
        segmentedControl.setTitleTextAttributes([.foregroundColor: CustomColors.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: CustomColors.gray], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let searchItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let coordinatesEntryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let latTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = CustomColors.darkGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.textColor = CustomColors.white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "Lat", attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray])
        return textField
    }()
    
    private let lonTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = CustomColors.darkGray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.textColor = CustomColors.white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "Lon", attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray])
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = CustomColors.primary
        button.setTitleColor(CustomColors.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = CustomColors.background
        setupMainStackView()
        fillMainStackView()
        fillSearchItemsStackView()
        fillCoordinatesEntryStackView()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        setMainStackViewConstraints()
    }
    
    private func fillMainStackView() {
        mainStackView.addArrangedSubview(searchOptionsSegmentedControl)
        mainStackView.addArrangedSubview(searchItemsStackView)
    }
    
    private func fillSearchItemsStackView() {
        searchItemsStackView.addArrangedSubview(coordinatesEntryStackView)
        searchItemsStackView.addArrangedSubview(searchButton)
    }
    
    private func fillCoordinatesEntryStackView() {
        coordinatesEntryStackView.addArrangedSubview(latTextField)
        coordinatesEntryStackView.addArrangedSubview(lonTextField)
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
