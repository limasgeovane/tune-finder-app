//
//  ListAlbumsViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbumsViewController: UIViewController {
    private let contentView: ListAlbumsView
    var albums: [Albums.Item] = []
    var artistName: String =  ""
    
    init(contentView: ListAlbumsView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configureTableViewDelegate(self, dataSource: self)
        contentView.artistTitle.text = "Álbuns de \(artistName)"
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

extension ListAlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

extension ListAlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAlbumsTableViewCell.identifier, for: indexPath) as? ListAlbumsTableViewCell else {
            return UITableViewCell()
        }
        
        let albums = albums[indexPath.row]
        cell.configureCell(albums: albums)
        return cell
    }
}
