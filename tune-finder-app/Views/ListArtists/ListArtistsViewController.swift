//
//  ListArtistsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 16/12/24.
//

import UIKit

class ListArtistsViewController: UIViewController, ListArtistsViewDelegate {
    private let contentView: ListArtistsView
    private let network: Network = Network()
    var artists: [Item] = []
    var lastArtistSearched: String?
    private let userDefaults = UserDefaults.standard
    
    
    private lazy var statusView: StatusView = {
        let view = StatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusViewController: StatusViewController = {
        let viewController = StatusViewController(contentView: statusView)
        return viewController
    }()
    
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
        setupStatusViewController()
        
        statusView.retryActionHandler = { [weak self] in
            if let seachrText = self?.contentView.searchArtistTextField.text {
                self?.searchArtist(artistName: seachrText)
            }
        }
        setupUI()
        
        if let lastArtistSearched = lastArtistSearched, !lastArtistSearched.isEmpty {
            searchArtist(artistName: lastArtistSearched)
        }
    }
    
    private func setupStatusViewController() {
        addChild(statusViewController)
        statusViewController.didMove(toParent: self)
        view.addSubview(statusView)
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: view.topAnchor),
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupConstraintsViewController(contentView: contentView)
    }
    
    func searchArtist(artistName: String) {
        userDefaults.removeObject(forKey: "hasSearchedBefore")
        userDefaults.removeObject(forKey: "lastArtistSearched")
        userDefaults.set(true, forKey: "hasSearchedBefore")
        userDefaults.set(artistName, forKey: "lastArtistSearched")
        
        self.contentView.isHidden = true
        
        statusViewController.setStatus(status: .loading(resource: "artistas"))
        network.getArtists(artistName: artistName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let artists):
                if artists.isEmpty {
                    self.statusViewController.setStatus(status: .empty(resource: "artistas"))
                } else {
                    self.artists = artists
                    self.contentView.artistsTableView.reloadData()
                    self.statusViewController.setStatus(status: .success)
                    self.contentView.isHidden = false
                }
            case .failure(let error):
                self.statusViewController.setStatus(status: .error)
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    func didSelectArtist(artistId: String, artistName: String) {
        self.contentView.isHidden = true
        
        statusViewController.setStatus(status: .loading(resource: "álbuns"))
        network.getAlbums(artistId: artistId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let albums):
                if albums.isEmpty {
                    self.statusViewController.setStatus(status: .empty(resource: "álbuns"))
                } else {
                    self.statusViewController.setStatus(status: .success)
                    self.navigateToListAlbumsViewController(albums: albums, artistName: artistName)
                }
            case .failure(let error):
                self.statusViewController.setStatus(status: .error)
                print("Erro: \(error.localizedDescription)")
            }
            
        }
    }
    
    private func navigateToListAlbumsViewController(albums: [Items], artistName: String) {
        let listAlbumsView = ListAlbumsView()
        let listAlbumsViewController = ListAlbumsViewController(contentView: listAlbumsView)
        listAlbumsViewController.albums = albums
        listAlbumsViewController.artistName = artistName
        navigationController?.pushViewController(listAlbumsViewController, animated: true)
    }
    
    func returnToPreviousView() {
        self.statusViewController.setStatus(status: .success)
        self.contentView.isHidden = false
        self.contentView.searchArtistTextField.text = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.viewWillAppear(true)
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
