//
//  HomeViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func homeDidSearchArtist(artists: [Artists.Artist.Item], artistName: String)
}

class HomeViewController: UIViewController {
    private lazy var statusView: StatusView = {
        let view = StatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusViewController: StatusViewController = {
        let viewController = StatusViewController(contentView: statusView)
        return viewController
    }()
    
    private let contentView: HomeView
    private let network: Network = Network()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusViewController()
        statusView.isHidden = true
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
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: view.topAnchor),
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewDelegate {
    func searchArtist(artistName: String) {
        self.contentView.isHidden = true
        self.statusView.isHidden = false
        
        statusViewController.setStatus(status: .loading(resource: "artistas"))
        network.getArtists(artistName: artistName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let artists):
                if artists.isEmpty {
                    self.statusViewController.setStatus(status: .empty(resource: "artistas"))
                    self.statusView.isHidden = false
                } else {
                    self.statusViewController.setStatus(status: .success)
                    self.statusView.isHidden = true
                    self.delegate?.homeDidSearchArtist(artists: artists, artistName: artistName)
                }
            case .failure(let error):
                self.statusViewController.setStatus(status: .error)
                self.statusView.isHidden = false
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
}
