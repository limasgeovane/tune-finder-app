//
//  HomeView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class HomeView: UIView {    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O que você gostaria de ouvir no TuneFinder?"
        label.textColor = .whitePrimaryColor
        label.font = .primaryFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchArtistTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Nome do artista...",
            attributes: [
                .foregroundColor: UIColor.graySecundaryColor,
                .font: UIFont.secondaryFont,
            ]
        )
        textField.backgroundColor = .grayPrimaryColor
        textField.textColor = .whitePrimaryColor
        textField.layer.cornerRadius = 32
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 50))
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(searchLabel)
        addSubview(searchArtistTextField)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 288),
            searchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -176),
            
            searchArtistTextField.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 136),
            searchArtistTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchArtistTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchArtistTextField.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
