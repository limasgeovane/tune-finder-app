//
//  AlbumsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

protocol AlbumsDisplayable: AnyObject {
    func displayAlbums(artistName: String, albums: [Album])
}

class AlbumsViewController: UIViewController {
    private let contentView: AlbumsViewLogic
    private var viewModel: AlbumsViewModelLogic
    
    init(contentView: AlbumsViewLogic, viewModel: AlbumsViewModelLogic) {
        self.contentView = contentView
        self.viewModel = viewModel
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
        viewModel.fetchAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension AlbumsViewController: AlbumsDisplayable {
    func displayAlbums(artistName: String, albums: [Album]) {
        contentView.artistName = artistName
        contentView.albums = albums
    }
}
