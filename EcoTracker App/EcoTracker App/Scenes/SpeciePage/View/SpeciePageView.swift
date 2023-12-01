//
//  SpeciePage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import UIKit

final class SpeciePageViewController: UIViewController {
    
    //MARK: - Properties
    private let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter City Name", attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray] )
        textField.borderStyle = .roundedRect
        textField.textColor = CustomColors.white
        textField.backgroundColor = CustomColors.darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        return textField
    }()
    
    private let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = CustomColors.primary
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitleColor(CustomColors.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel = SpeciePageViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = CustomColors.background
        view.addSubview(cityNameTextField)
        view.addSubview(fetchButton)
        setupConstraints()
        addActionForButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fetchButton.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 20),
            fetchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fetchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fetchButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func addActionForButton() {
        fetchButton.addAction(UIAction(handler: { [weak self] _ in
            guard let cityName = self?.cityNameTextField.text else {
                return 
            }

            self?.viewModel.fetchCityID(for: cityName) { result in
                switch result {
                case .success(let fetchedCityId):
                    DispatchQueue.main.async {
                        self?.presentSecondView(with: fetchedCityId)
                    }
                case .failure(let error):
                    // Handle error
                    print("Error fetching city ID: \(error)")
                }
            }
        }), for: .touchUpInside)
    }
    
    private func presentSecondView(with cityID: Int) {
        let secondViewController = SpeciesResultView()
        secondViewController.cityID = cityID
        self.present(secondViewController, animated: true, completion: nil)
    }
}
