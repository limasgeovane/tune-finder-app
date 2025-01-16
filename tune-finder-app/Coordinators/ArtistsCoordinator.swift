//
//  ArtistsCoordinator.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 14/01/25.
//

import UIKit

class ArtistsCoordinator {
    private let navigationController: UINavigationController
    private let artists: [Artists.Artist.Item]
    private let artistName: String
    
    init(navigationController: UINavigationController, artists: [Artists.Artist.Item], artistName: String) {
        self.navigationController = navigationController
        self.artists = artists
        self.artistName = artistName
    }
    
    func start() {
        let listArtitsView = ListArtistsView()
        let listArtistsViewController = ListArtistsViewController(contentView: listArtitsView, delegate: self)
        listArtistsViewController.artists = artists
        listArtistsViewController.lastArtistSearched = artistName
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
