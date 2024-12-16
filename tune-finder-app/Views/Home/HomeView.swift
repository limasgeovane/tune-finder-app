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

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .whitePrimaryColor
        searchBar.placeholder = "Nome do artista..."
        searchBar.barTintColor = .whitePrimaryColor
        searchBar.searchTextField.textColor = .grayContrastColor
        searchBar.layer.cornerRadius = 22
        searchBar.searchTextField.layer.masksToBounds = true
        return searchBar
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
        addSubview(searchBar)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 288),
            searchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -176),
            
            searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 136),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
