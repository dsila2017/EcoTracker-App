//
//  PopUp.swift
//  EcoTracker App
//
//  Created by David on 11/30/23.
//

import UIKit

final class PopUpPageView: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryLabel, topStackView, bottomStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todayLabel, todayDateLabel, todayNumberLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tomorrowLabel, tomorrowDateLabel, tomorrowNumberLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let countryLabel:UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.white
        return label
    }()
    
    private let todayLabel:UILabel = {
        let label = UILabel()
        label.text = "Today's Population:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private let tomorrowLabel:UILabel = {
        let label = UILabel()
        label.text = "Tomorrow's Population:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private let todayNumberLabel:UILabel = {
        let label = UILabel()
        label.text = "140000"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private let tomorrowNumberLabel:UILabel = {
        let label = UILabel()
        label.text = "170000"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private let todayDateLabel:UILabel = {
        let label = UILabel()
        label.text = "30 Nov 2023"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private let tomorrowDateLabel:UILabel = {
        let label = UILabel()
        label.text = "1 Dec 2023"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = CustomColors.background
        setupMainView()
    }
    
    private func setupMainView() {
        view.addSubview(mainStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            countryLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
            topStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.45),
            bottomStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.45),
            
            
        ])
        
    }


}
