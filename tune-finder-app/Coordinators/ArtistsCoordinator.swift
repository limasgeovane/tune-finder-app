//
//  ArtistsCoordinator.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 14/01/25.
//

import UIKit

class ArtistsCoordinator {
    private let navigationController: UINavigationController
    private let artistName: String
    private let isShowLastArtist: Bool
    
    init(navigationController: UINavigationController, artistName: String, isShowLastArtist: Bool) {
        self.navigationController = navigationController
        self.artistName = artistName
        self.isShowLastArtist = isShowLastArtist
    }
    
    func start() {
        let listArtitsView = ListArtistsView()
        let listArtistsViewController = ListArtistsViewController(
            contentView: listArtitsView,
            artistName: artistName,
            network: Network(),
            isShowLastArtist: isShowLastArtist,
            delegate: self
        )
        navigationController.pushViewController(listArtistsViewController, animated: true)
    }
}

extension ArtistsCoordinator: ListArtistsViewControllerDelegate {
    func listArtistsDidSelectArtist(albums: [Albums.Item], artistName: String) {
        let listAlbumsView = ListAlbumsView()
        let listAlbumsViewController = ListAlbumsViewController(contentView: listAlbumsView)
        listAlbumsViewController.albums = albums
        listAlbumsViewController.artistName = artistName
        navigationController.pushViewController(listAlbumsViewController, animated: true)
    }
}
