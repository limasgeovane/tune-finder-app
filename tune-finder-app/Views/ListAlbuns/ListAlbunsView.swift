//
//  ListAlbunsView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbunsView: UIView {
    private lazy var artistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Álbuns de Michael Jackson"
        label.textColor = .whitePrimaryColor
        label.font = .primaryFont
        return label
    }()
    
    private lazy var albunsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListAlbunsTableViewCell.self, forCellReuseIdentifier: ListAlbunsTableViewCell.identifier)
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
        addSubview(artistTitle)
        addSubview(albunsTableView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            artistTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistTitle.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            
            albunsTableView.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 32),
            albunsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            albunsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            albunsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        albunsTableView.delegate = delegate
        albunsTableView.dataSource = dataSource
    }
}
