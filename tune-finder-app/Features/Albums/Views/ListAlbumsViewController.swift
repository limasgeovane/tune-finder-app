//
//  ListAlbumsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbumsViewController: UIViewController {
    var albums: [Albums.Item] = []
    
    private let contentView: ListAlbumsView
    private let repository: AlbumsRepository
    private let artistName: String
    private let artistId: String
    
    init(contentView: ListAlbumsView, repository: AlbumsRepository, artistName: String, artistId: String) {
        self.contentView = contentView
        self.repository = repository
        self.artistName = artistName
        self.artistId = artistId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configureTableViewDelegate(self, dataSource: self)
        fetchAlbums()
        contentView.artistTitle.text = "Álbuns de \(artistName)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func fetchAlbums() {
        repository.fetchAlbums(artistId: artistId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums.items
                self.contentView.albumsTableView.reloadData()
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
}

extension ListAlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

extension ListAlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAlbumsTableViewCell.identifier, for: indexPath) as? ListAlbumsTableViewCell else {
            return UITableViewCell()
        }
        
        let albums = albums[indexPath.row]
        cell.configureCell(albums: albums)
        return cell
    }
}
