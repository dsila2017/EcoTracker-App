//
//  SpeciePage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import UIKit

class SpeciePageViewController: UIViewController {
    
    //MARK: - Properties
    let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter City Name", attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray] )
        textField.borderStyle = .roundedRect
        textField.textColor = CustomColors.white
        textField.backgroundColor = CustomColors.darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch Species Info", for: .normal)
        button.backgroundColor = CustomColors.primary
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
            let resultViewController = SpeciesResultView()
            self?.present(resultViewController, animated: true)
        }), for: .touchUpInside)
    }
}
