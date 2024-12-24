//
//  ListArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

class ListArtistsViewController: UIViewController, ListArtistsViewDelegate {
    private let contentView: ListArtistsView
    private let service: Service = Service()
    var artists: [Item] = []
    
    init(contentView: ListArtistsView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configureTableViewDelegate(self, dataSource: self)
        contentView.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
    
    func searchArtist(artistName: String) {
        service.getArtists(tokenType: Service.tokenType, accessToken: Service.accessToken, artistName: artistName) {[weak self] artists in
            self?.artists = artists
            self?.contentView.artistsTableView.reloadData()
        }
    }
    
    func didSelectArtist(artistId: String, artistName: String) {
        service.getAlbums(tokenType: Service.tokenType, accessToken: Service.accessToken, artistId: artistId) { [weak self] albums in
            self?.navigateToListAlbumsViewController(albums: albums, artistName: artistName)
        }
    }
    
    private func navigateToListAlbumsViewController(albums: [Items], artistName: String) {
        let listAlbumsView = ListAlbumsView()
        let listAlbumsViewController = ListAlbumsViewController(contentView: listAlbumsView)
        listAlbumsViewController.albums = albums
        listAlbumsViewController.artistName = artistName
        navigationController?.pushViewController(listAlbumsViewController, animated: true)
    }
}
