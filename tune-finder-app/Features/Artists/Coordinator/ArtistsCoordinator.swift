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
        let artitsView = ArtistsView()
        let viewModel = ArtistsViewModel(
            repository: ArtistsRepository(),
            artistName: artistName,
            isShowLastArtist: isShowLastArtist
        )
        let ArtistsViewController = ArtistsViewController(
            contentView: artitsView,
            viewModel: viewModel,
            delegate: self
        )
        navigationController.pushViewController(ArtistsViewController, animated: true)
    }
}

extension ArtistsCoordinator: ArtistsViewControllerDelegate {
    func ArtistsDidSelectArtist(artistId: String, artistName: String) {
        let albumsView = AlbumsView()
        let viewModel = AlbumsViewModel(repository: AlbumsRepository(), artistId: artistId, artistName: artistName)
        let albumsViewController = AlbumsViewController(
            contentView: albumsView,
            viewModel: viewModel
        )
        navigationController.pushViewController(albumsViewController, animated: true)
    }
}
