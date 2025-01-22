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
        let viewModel = ArtistsViewModel(repository: ArtistsRepository(), artistName: artistName)
        let listArtistsViewController = ListArtistsViewController(
            contentView: listArtitsView,
            isShowLastArtist: isShowLastArtist,
            viewModel: viewModel,
            delegate: self
        )
        navigationController.pushViewController(listArtistsViewController, animated: true)
    }
}

extension ArtistsCoordinator: ListArtistsViewControllerDelegate {
    func listArtistsDidSelectArtist(artistId: String, artistName: String) {
        let listAlbumsView = ListAlbumsView()
        let viewModel = AlbumsViewModel(repository: AlbumsRepository(), artistId: artistId)
        let listAlbumsViewController = ListAlbumsViewController(
            contentView: listAlbumsView,
            artistName: artistName,
            viewModel: viewModel
        )
        navigationController.pushViewController(listAlbumsViewController, animated: true)
    }
}
