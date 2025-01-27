//
//  ArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

protocol ArtistsViewControllerDelegate: AnyObject {
    func ArtistsDidSelectArtist(artistId: String, artistName: String)
}

protocol ArtistsDisplayable: AnyObject {
    func displayArtists(isShowLastArtist: Bool, artists: [Artist])
    func displayArtist(id: String, name: String)
}

class ArtistsViewController: UIViewController {
    private let contentView: ArtistsViewLogic
    private var viewModel: ArtistsViewModelLogic
    private weak var delegate: ArtistsViewControllerDelegate?
    
    init(
        contentView: ArtistsViewLogic,
        viewModel: ArtistsViewModelLogic,
        delegate: ArtistsViewControllerDelegate
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.delegate = delegate
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
        viewModel.display = self
        contentView.delegate = self
        viewModel.fetchArtists()
        title = "Artistas"
    }
}

extension ArtistsViewController: ArtistsDisplayable {
    func displayArtists(isShowLastArtist: Bool, artists: [Artist]) {
        contentView.isShowLastArtist = isShowLastArtist
        contentView.artists = artists
    }
    
    func displayArtist(id: String, name: String) {
        delegate?.ArtistsDidSelectArtist(artistId: id, artistName: name)
    }
}

extension ArtistsViewController: ArtistsViewDelegate {
    func didSelectArtist(indexPath: IndexPath) {
        viewModel.selectArtist(indexPath: indexPath)
    }
    
    func searchArtist(artistName: String) {
        viewModel.fetchArtists(artistName: artistName   )
    }
}
