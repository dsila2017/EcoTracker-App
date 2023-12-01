//
//  EcoTextField.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import UIKit

final class EcoTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = CustomColors.darkGray
        textColor = CustomColors.white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .left
        tintColor = CustomColors.white
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setPlaceholder(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: CustomColors.gray]
        )
    }
}
