//
//  HomeViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    private let contentView: HomeView
    private let service: Service = Service()
    
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
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
    
    func searchArtist(artistName: String) {
        service.getArtists(tokenType: Service.tokenType, accessToken: Service.accessToken, artistName: artistName) { [weak self] artists in
            self?.navigateToListArtistsViewController(artists: artists)
        }
    }
    
    private func navigateToListArtistsViewController(artists: [Item]) {
        let listArtistsView = ListArtistsView()
        let listArtistsViewController = ListArtistsViewController(contentView: listArtistsView)
        listArtistsViewController.artists = artists
        navigationController?.pushViewController(listArtistsViewController, animated: true)
    }
}
