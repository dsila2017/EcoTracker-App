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
        viewModel.delegate = self
        
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
            cityNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameTextField.widthAnchor.constraint(equalToConstant: 320),
            
            fetchButton.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 20),
            fetchButton.leadingAnchor.constraint(equalTo: cityNameTextField.leadingAnchor),
            fetchButton.widthAnchor.constraint(equalToConstant: 320),
            fetchButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func shakeTextField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true

        let fromPoint = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        let toPoint = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        animation.fromValue = NSValue(cgPoint: fromPoint)
        animation.toValue = NSValue(cgPoint: toPoint)

        textField.layer.add(animation, forKey: "position")
    }
    
    private func addActionForButton() {
        fetchButton.addAction(UIAction(handler: { [weak self] _ in
            guard let cityName = self?.cityNameTextField.text else {
                return
            }
            self?.viewModel.buttonTapped(for: cityName)
        }), for: .touchUpInside)
    }
}

//MARK: - SpeciePageViewModel Delegate
extension SpeciePageViewController: SpeciePageViewModelDelegate {
    func cityFetched(_ city: City) {
        DispatchQueue.main.async{
            self.present(SpeciesResultView(city: city), animated: true, completion: nil)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async{
            self.shakeTextField(textField: self.cityNameTextField)
        }
        print(error)
    }
}

