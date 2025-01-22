//
//  ListArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

protocol ListArtistsViewControllerDelegate: AnyObject {
    func listArtistsDidSelectArtist(artistId: String, artistName: String)
}

protocol ListArtistsDisplayable: AnyObject {
    func displayArtists(artists: [Artist])
    func displayArtist(id: String, name: String)
}

class ListArtistsViewController: UIViewController {
    private let contentView: ListArtistsView
    private let isShowLastArtist: Bool
    private var viewModel: ArtistsViewModelLogic
    private weak var delegate: ListArtistsViewControllerDelegate?
    
    init(contentView: ListArtistsView, isShowLastArtist: Bool, viewModel: ArtistsViewModelLogic, delegate: ListArtistsViewControllerDelegate) {
        self.contentView = contentView
        self.isShowLastArtist = isShowLastArtist
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
        contentView.setupLastSearchState(isShowLastArtist: isShowLastArtist)
        viewModel.fetchArtists()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
    }
}

extension ListArtistsViewController: ListArtistsDisplayable {
    func displayArtists(artists: [Artist]) {
        contentView.artists = artists
    }
    
    func displayArtist(id: String, name: String) {
        delegate?.listArtistsDidSelectArtist(artistId: id, artistName: name)
    }
}

extension ListArtistsViewController: ListArtistsViewDelegate {
    func didSelectArtist(indexPath: IndexPath) {
        viewModel.selectArtist(indexPath: indexPath)
    }
    
    func searchArtist(artistName: String) {
        viewModel.fetchArtists(artistName: artistName   )
    }
}
