//
//  PopulationPage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//
import UIKit

final class PopulationPageViewController: UIViewController {
    
    // MARK: - UI Components + Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainTopView, bottomStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bottomTopHalfView, bottomBottomHalfView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let mainPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Get Population   ", for: .normal)
        button.backgroundColor = CustomColors.primary
        button.setTitleColor(CustomColors.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.tintColor = CustomColors.primary
        button.addAction(UIAction(handler: { [weak self] _ in
            let vc = PopUpPageView(country: self?.country ?? "")
            self?.navigationController?.present(vc, animated: true)
        }), for: .touchUpInside)
        
        return button
    }()
    
    private let mainTopView = UIView()
    private let bottomTopHalfView = UIView()
    private let bottomBottomHalfView = UIView()
    
    var pickerData = CountriesModel(countries: [])
    var model = PopulationPageViewModel()
    
    var country = "Afghanistan"
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegate()
        model.viewDidLoad(countries: pickerData)
    }
    
    // MARK: - Private Methods
    private func setupDelegate() {
        model.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = CustomColors.background
        view.addSubview(mainStackView)
        mainTopView.addSubview(mainPicker)
        bottomBottomHalfView.addSubview(mainButton)
        mainPicker.delegate = self
        mainPicker.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainTopView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.6),
            
            mainPicker.centerXAnchor.constraint(equalTo: mainTopView.centerXAnchor),
            mainPicker.bottomAnchor.constraint(equalTo: mainTopView.bottomAnchor),
            
            mainButton.centerXAnchor.constraint(equalTo: bottomBottomHalfView.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: bottomBottomHalfView.centerYAnchor),
            
        ])
    }
}

// MARK: - UIPickerViewDataSource
extension PopulationPageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData.countries[row] ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

// MARK: - UIPickerViewDelegate
extension PopulationPageViewController: UIPickerViewDelegate {
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            country = pickerData.countries[row] ?? "Afghanistan"
        }
}
