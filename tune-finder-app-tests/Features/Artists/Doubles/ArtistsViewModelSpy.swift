//
//  ArtistsViewModelSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import Foundation

class ArtistsViewModelSpy: ArtistsViewModelLogic {
    var displayGetterCount = 0
    var stubbedDisplay: ListArtistsDisplayable?
    var displaySetterCount = 0
    var invokedDisplay: ListArtistsDisplayable?

    var display: ListArtistsDisplayable? {
        get {
            displayGetterCount += 1
            return stubbedDisplay
        }
        set {
            displaySetterCount += 1
            invokedDisplay = newValue
        }
    }

    var fetchArtistsCount = 0

    func fetchArtists() {
        fetchArtistsCount += 1
    }

    var fetchArtistsArtistNameCount = 0
    var fetchArtistsArtistNameParameterArtistName: String?
    
    func fetchArtists(artistName: String) {
        fetchArtistsArtistNameCount += 1
        fetchArtistsArtistNameParameterArtistName = artistName
    }

    var selectArtistCount = 0
    var selectArtistParameterIndexPath: IndexPath?

    func selectArtist(indexPath: IndexPath) {
        selectArtistCount += 1
        selectArtistParameterIndexPath = indexPath
    }
}
