//
//  ListArtistsView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

class ListArtistsView: UIView {
    weak var delegate: ListArtistsViewDelegate?
    
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
        button.addTarget(self, action: #selector(clearSearchArtistTextField), for: .touchUpInside)
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
    
    lazy var artistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListArtistsTableViewCell.self, forCellReuseIdentifier: ListArtistsTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        searchArtistTextField.delegate = self
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
            searchStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            searchStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
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
    
    @objc
    private func clearSearchArtistTextField() {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.cancelButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.cancelButton.setTitleColor(.greenSecondaryColor, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.cancelButton.transform = CGAffineTransform.identity
                self.cancelButton.setTitleColor(.whitePrimaryColor, for: .normal)
            }
        })
        searchArtistTextField.text = ""
    }
}
