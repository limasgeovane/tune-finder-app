//
//  HomeViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    private let contentView: HomeView
    private let network: Network = Network()
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
    
    init(contentView: HomeView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusViewController()
        
        statusView.retryActionHandler = { [weak self] in
            if let searchText = self?.contentView.searchArtistTextField.text {
                self?.searchArtist(artistName: searchText)
            }
        }
        setupUI()
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
        self.contentView.isHidden = true
        
        statusViewController.setStatus(status: .loading(resource: "artistas"))
        network.getArtists(tokenType: Network.tokenType, accessToken: Network.accessToken, artistName: artistName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let artists):
                if artists.isEmpty {
                    self.statusViewController.setStatus(status: .empty(resource: "artistas"))
                } else {
                    self.statusViewController.setStatus(status: .success)
                    self.navigateToListArtistsViewController(artists: artists, artistName: artistName)
                }
            case .failure(let error):
                self.statusViewController.setStatus(status: .error)
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    private func navigateToListArtistsViewController(artists: [Item], artistName: String) {
        userDefaults.set(true, forKey: "hasSearchedBefore")
        userDefaults.set(artistName, forKey: "lastArtistSearched")
        
        let listArtistsView = ListArtistsView()
        let listArtistsViewController = ListArtistsViewController(contentView: listArtistsView)
        listArtistsViewController.artists = artists
        navigationController?.pushViewController(listArtistsViewController, animated: true)
    }
    
    func returnToPreviousView() {
        self.statusViewController.setStatus(status: .success)
        self.contentView.isHidden = false
        self.contentView.searchArtistTextField.text = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.viewWillAppear(true)
    }
}
