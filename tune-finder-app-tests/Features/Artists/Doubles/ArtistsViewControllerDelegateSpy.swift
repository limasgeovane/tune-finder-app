//
//  ArtistsViewControllerDelegateSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import Foundation

class ArtistsViewControllerDelegateSpy: ArtistsViewControllerDelegate {
    var ArtistsDidSelectArtistCount = 0
    var ArtistsDidSelectArtistParameterArtistId: String?
    var ArtistsDidSelectArtistParameterArtistName: String?
    
    func ArtistsDidSelectArtist(artistId: String, artistName: String) {
        ArtistsDidSelectArtistCount += 1
        ArtistsDidSelectArtistParameterArtistId = artistId
        ArtistsDidSelectArtistParameterArtistName = artistName
    }
}
