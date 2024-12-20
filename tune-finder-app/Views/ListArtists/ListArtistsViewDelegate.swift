//
//  ListArtistsViewDelegate.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 20/12/24.
//

import Foundation

protocol ListArtistsViewDelegate: AnyObject {
    func didSelectArtist(artistId: String)
}
