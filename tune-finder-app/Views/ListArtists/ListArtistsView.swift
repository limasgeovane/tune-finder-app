//
//  ListArtistsView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

class ListArtistsView: UIView {
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
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.whitePrimaryColor, for: .normal)
        button.titleLabel?.font = .buttonFont
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchArtistTextField, cancelButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var artistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListArtistsTableViewCell.self, forCellReuseIdentifier: ListArtistsTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(searchStackView)
        addSubview(artistsTableView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            artistsTableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 16),
            artistsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            artistsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            artistsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        artistsTableView.delegate = delegate
        artistsTableView.dataSource = dataSource
    }
}
