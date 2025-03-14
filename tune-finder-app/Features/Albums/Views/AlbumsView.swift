//
//  AlbumsView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

protocol AlbumsViewLogic: UIView, AnyObject {
    var artistName: String { get set }
    var albums: [Album] { get set }
}

class AlbumsView: UIView, AlbumsViewLogic {
    var artistName: String = "" {
        didSet {
            artistTitle.text = artistName
        }
    }
    
    var albums: [Album] = [] {
        didSet {
            albumsTableView.reloadData()
        }
    }
    
    private let artistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .whitePrimaryColor
        label.font = .primaryFont
        return label
    }()
    
    private lazy var albumsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: AlbumsTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
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
        backgroundColor = .black
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
}

extension AlbumsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

extension AlbumsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsTableViewCell.identifier, for: indexPath) as? AlbumsTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configureCell(album: album)
        return cell
    }
}
