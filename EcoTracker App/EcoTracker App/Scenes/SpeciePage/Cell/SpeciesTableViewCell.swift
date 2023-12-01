//
//  SpeciesTableViewCell.swift
//  EcoTracker App
//
//  Created by nika razmadze on 01.12.23.
//

import UIKit
import Kingfisher

final class SpeciesTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private var specieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 117).isActive = true
        return imageView
    }()

    private var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = CustomColors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var publisherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = CustomColors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var wikipediaLinkLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTitleLabel, publisherLabel, wikipediaLinkLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [specieImageView, textStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = CustomColors.background
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupSubviews() {
        contentView.addSubview(mainStackView)
    }
    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Configure
    func configure(with specie: SpeciesInfo) {
        let url = URL(string: specie.taxon.defaultPhoto.url)
        specieImageView.kf.setImage(with: url)
        nameTitleLabel.text = specie.taxon.name
        publisherLabel.text = specie.taxon.defaultPhoto.attribution
        wikipediaLinkLabel.text = specie.taxon.wikipediaURL
    }
}


