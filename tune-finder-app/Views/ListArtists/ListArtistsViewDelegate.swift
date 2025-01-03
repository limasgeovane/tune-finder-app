//
//  ListArtistsViewDelegate.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 20/12/24.
//

protocol ListArtistsViewDelegate: AnyObject {
    func didSelectArtist(artistId: String, artistName: String)
    func searchArtist(artistName: String)
}
