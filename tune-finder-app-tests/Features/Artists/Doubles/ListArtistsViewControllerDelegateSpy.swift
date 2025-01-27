//
//  ListArtistsViewControllerDelegateSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import Foundation

class ListArtistsViewControllerDelegateSpy: ListArtistsViewControllerDelegate {
    var listArtistsDidSelectArtistCount = 0
    var listArtistsDidSelectArtistParameterArtistId: String?
    var listArtistsDidSelectArtistParameterArtistName: String?
    
    func listArtistsDidSelectArtist(artistId: String, artistName: String) {
        listArtistsDidSelectArtistCount += 1
        listArtistsDidSelectArtistParameterArtistId = artistId
        listArtistsDidSelectArtistParameterArtistName = artistName
    }
}
