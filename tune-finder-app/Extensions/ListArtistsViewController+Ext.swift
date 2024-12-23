//
//  ListArtistsViewController+Ext.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

extension ListArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = artists[indexPath.row]
        didSelectArtist(artistId: selectedArtist.id)
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
