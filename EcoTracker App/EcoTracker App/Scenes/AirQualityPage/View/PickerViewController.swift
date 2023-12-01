//
//  CountryPickerViewController.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import UIKit

protocol PickerDelegate: AnyObject {
    func didSelect(to item: String, for type: PickerType)
}

enum PickerType {
    case country
    case state
    case city
}

final class PickerViewController: UIViewController {
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
        return pickerView
    }()
    
    private lazy var button: UIButton = {
        let button = EcoButton()
        button.setTitle("Choose", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addOnTouchUpInsideAction(buttonDidTap)
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: PickerDelegate?
    
    private var selectedItem: String
    
    private func buttonDidTap() {
        delegate?.didSelect(to: selectedItem, for: pickerType)
        dismiss(animated: true)
    }
    
    private let items: [String]
    
    private let pickerType: PickerType
    
    init(_ items: [String], for type: PickerType) {
        self.items = items
        self.pickerType = type
        self.selectedItem = items[0]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .background
        
        title = "Select Country"
        navigationController?.navigationBar.largeContentTitle = "SELECT Country"
        
        view.addSubview(pickerView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
    }
}
