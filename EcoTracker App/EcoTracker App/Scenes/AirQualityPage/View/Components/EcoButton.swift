//
//  EcoButton.swift
//  EcoTracker App
//
//  Created by Natia Khizanishvili on 01.12.23.
//

import UIKit

final class EcoButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func addOnTouchUpInsideAction(_ handler: @escaping () -> Void) {
        addAction(
            UIAction(handler: { _ in handler() }),
            for: .touchUpInside
        )
    }
    
    private func setupUI() {
        backgroundColor = CustomColors.primary
        setTitleColor(CustomColors.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
