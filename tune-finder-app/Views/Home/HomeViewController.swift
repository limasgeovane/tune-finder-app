//
//  HomeViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func homeDidSearchArtist(artistName: String)
}

class HomeViewController: UIViewController {
    private let contentView: HomeView
    private weak var delegate: HomeViewControllerDelegate?
    
    init(contentView: HomeView, delegate: HomeViewControllerDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
}

extension HomeViewController: HomeViewDelegate {
    func searchArtist(artistName: String) {
        delegate?.homeDidSearchArtist(artistName: artistName)
    }
}
