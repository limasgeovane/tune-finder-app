//
//  ListAlbumsView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbumsView: UIView {
    lazy var artistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Álbuns de Michael Jackson"
        label.textColor = .whitePrimaryColor
        label.font = .primaryFont
        return label
    }()
    
    private lazy var albumsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListAlbumsTableViewCell.self, forCellReuseIdentifier: ListAlbumsTableViewCell.identifier)
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
        addSubview(albumsTableView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            artistTitle.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            artistTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            
            albumsTableView.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 32),
            albumsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            albumsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            albumsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        albumsTableView.delegate = delegate
        albumsTableView.dataSource = dataSource
    }
}
