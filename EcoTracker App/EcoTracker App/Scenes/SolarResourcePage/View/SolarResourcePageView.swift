//
//  SolarResourcePage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//

import UIKit

class SolarResourcePageViewController: UIViewController {

    private lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search by address"
        textField.backgroundColor = CustomColors.darkGray
        textField.textColor = CustomColors.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textAlignment = .left
        textField.tintColor = CustomColors.white
        
        setupTextField(textField)
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = CustomColors.primary
        button.setTitleColor(CustomColors.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.background
        setupViews()
    }
    
    private func setupTextField(_ textField: UITextField) {
        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray]
            )
        }
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
    }
    
    private func setupViews() {
        view.addSubview(searchField)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            searchField.widthAnchor.constraint(equalToConstant: 320),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 320),
            searchButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}


