//
//  PopulationPage.swift
//  EcoTracker App
//
//  Created by David on 11/29/23.
//
import UIKit

final class PopulationPageViewController: UIViewController {
    
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
    
    private let mainPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Get Population   ", for: .normal)
        button.backgroundColor = CustomColors.primary
        button.setTitleColor(CustomColors.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.tintColor = CustomColors.primary
        button.addAction(UIAction(handler: { _ in
            print("Hello")
        }), for: .touchUpInside)
        
        return button
    }()
    
    private let mainTopView = UIView()
    private let bottomTopHalfView = UIView()
    private let bottomBottomHalfView = UIView()
    
    var pickerData = ["Georgia","Belgium","Argentina","Germany","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
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

extension PopulationPageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    
}

// Don't Need Yet
extension PopulationPageViewController: UIPickerViewDelegate {
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        self.mainButton.titleLabel?.text = pickerData[row]
    //    }
}
