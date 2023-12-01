//
//  EcoTextField.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import UIKit

final class EcoTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = CustomColors.darkGray
        textColor = CustomColors.white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .left
        tintColor = CustomColors.white
    }
}
