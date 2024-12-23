//
//  ListAlbumsViewController+Ext\.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

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
