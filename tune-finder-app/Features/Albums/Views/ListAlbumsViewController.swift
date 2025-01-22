//
//  ListAlbumsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

protocol ListAlbumsDisplayable: AnyObject {
    func displayAlbums(albums: [Album])
}

class ListAlbumsViewController: UIViewController {
    private let contentView: ListAlbumsView
    private let artistName: String
    private var viewModel: AlbumsViewModelLogic
    
    init(contentView: ListAlbumsView, artistName: String, viewModel: AlbumsViewModelLogic) {
        self.contentView = contentView
        self.artistName = artistName
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
        contentView.artistTitle.text = "Álbuns de \(artistName)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension ListAlbumsViewController: ListAlbumsDisplayable {
    func displayAlbums(albums: [Album]) {
        contentView.albums = albums
    }
}
