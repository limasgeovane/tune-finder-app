//
//  ListArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

class ListArtistsViewController: UIViewController, ListArtistsViewDelegate {
    private let contentView: ListArtistsView
    private let service: Service
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
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
    
    func didSelectArtist(artistId: String) {
        service.getAlbums(tokenType: Service.tokenType, accessToken: Service.accessToken, artistId: "5ukVsGwdu2xaIWF4ytxBtm") { [weak self] albums in
            self?.navigateToListAlbumsViewController(albums: albums)
        }
       
    }
    
    private func navigateToListAlbumsViewController(albums: [Items]) {
        let listAlbumsView = ListAlbumsView()
        let listAlbumsViewController = ListAlbumsViewController(contentView: listAlbumsView)
        listAlbumsViewController.albums = albums
        navigationController?.pushViewController(listAlbumsViewController, animated: true)
    }
}
