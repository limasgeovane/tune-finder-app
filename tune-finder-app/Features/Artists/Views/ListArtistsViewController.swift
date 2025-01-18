//
//  ListArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

protocol ListArtistsViewControllerDelegate: AnyObject {
    func listArtistsDidSelectArtist(albums: [Albums.Item], artistName: String)
}

class ListArtistsViewController: UIViewController {
    private var artists: [Artists.Artist.Item] = []

    private let contentView: ListArtistsView
    private var artistName: String
    private let network: Network
    private let isShowLastArtist: Bool
    private weak var delegate: ListArtistsViewControllerDelegate?
    
    init(contentView: ListArtistsView, artistName: String, network: Network, isShowLastArtist: Bool, delegate: ListArtistsViewControllerDelegate) {
        self.contentView = contentView
        self.artistName = artistName
        self.network = network
        self.isShowLastArtist = isShowLastArtist
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
        contentView.configureTableViewDelegate(self, dataSource: self)
        contentView.delegate = self
        contentView.setupLastSearchState(isShowLastArtist: isShowLastArtist)
        searchArtist(artistName: artistName)
    }
}

extension ListArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = artists[indexPath.row]
        didSelectArtist(artistId: selectedArtist.id, artistName: selectedArtist.name)
    }
}

extension ListArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListArtistsTableViewCell.identifier, for: indexPath) as? ListArtistsTableViewCell else {
            return UITableViewCell()
        }
        let artist = artists[indexPath.row]
        cell.configureCell(artist: artist)
        return cell
    }
}

extension ListArtistsViewController: ListArtistsViewDelegate {
    func searchArtist(artistName: String) {
        UserDefaults.standard.set(artistName, forKey: "lastArtistSearched")
        
        network.getArtists(artistName: artistName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let artists):
                self.artists = artists
                contentView.artistsTableView.reloadData()
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    func didSelectArtist(artistId: String, artistName: String) {
        network.getAlbums(artistId: artistId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                delegate?.listArtistsDidSelectArtist(albums: albums, artistName: artistName)
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
            
        }
    }
}
