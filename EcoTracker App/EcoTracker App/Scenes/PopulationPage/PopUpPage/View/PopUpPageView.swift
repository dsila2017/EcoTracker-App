//
//  PopUp.swift
//  EcoTracker App
//
//  Created by David on 11/30/23.
//

import UIKit

final class PopUpPageView: UIViewController {
    
    // MARK: - UI Components + Properties
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
    
    private var countryLabel:UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.white
        return label
    }()
    
    private var todayLabel:UILabel = {
        let label = UILabel()
        label.text = "Today's Population:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private var tomorrowLabel:UILabel = {
        let label = UILabel()
        label.text = "Tomorrow's Population:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private var todayNumberLabel:UILabel = {
        let label = UILabel()
        label.text = "140000"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private var tomorrowNumberLabel:UILabel = {
        let label = UILabel()
        label.text = "170000"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private var todayDateLabel:UILabel = {
        let label = UILabel()
        label.text = "30 Nov 2023"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    private var tomorrowDateLabel:UILabel = {
        let label = UILabel()
        label.text = "1 Dec 2023"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = CustomColors.gray
        return label
    }()
    
    var population = PopulationModel(totalPopulation: [])
    var model: PopUpPageViewModel?
    
    var country: String?
    
    // MARK: - Init
    init(country: String) {
        super.init(nibName: nil, bundle: nil)
        self.country = country
        model = PopUpPageViewModel(country: country)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = CustomColors.background
        setupMainView()
        model!.viewDidLoad(population: population)
    }
    
    // MARK: - Methods
    private func setupDelegate() {
        model!.delegate = self
    }
    
    private func setupMainView() {
        view.addSubview(mainStackView)
        setupConstraints()
        setupDelegate()
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
    
    func updateUI(updateModel: PopulationModel) {
        countryLabel.text = country
        todayDateLabel.text = updateModel.totalPopulation[0].date
        todayNumberLabel.text = String(updateModel.totalPopulation[0].population)
        tomorrowDateLabel.text = updateModel.totalPopulation[1].date
        tomorrowNumberLabel.text = String(updateModel.totalPopulation[1].population )
    }
    
    
}
