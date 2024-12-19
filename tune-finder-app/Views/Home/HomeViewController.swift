//
//  HomeViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let contentView: HomeView
    private let service: Service
    private let tokenType = "Bearer"
    private let accessToken = "BQBWD68q4aCXgj-lrU9LVza62rCQJJkOkkn5RgdIVmwYFWLAIXMYEDKPRyJs8uBYOzyD6PvR5sfhdi5u4AR6mM6cYbCc8vZXFSsghJuByvB1ZGFUNEU"
    
    init(contentView: HomeView, service: Service) {
        self.contentView = contentView
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getArtists(tokenType: tokenType, accessToken: accessToken, artistName: "Jaloo")
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
}
