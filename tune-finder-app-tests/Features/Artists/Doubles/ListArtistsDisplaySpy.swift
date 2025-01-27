//
//  ListArtistsDisplaySpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app

class ListArtistsDisplaySpy: ListArtistsDisplayable {
    var displayArtistsCount = 0
    var displayArtistsParameterIsShowLastArtist = false
    var displayArtistsParameterArtists: [Artist] = []

    func displayArtists(isShowLastArtist: Bool, artists: [Artist]) {
        displayArtistsCount += 1
        displayArtistsParameterIsShowLastArtist = isShowLastArtist
        displayArtistsParameterArtists = artists
    }

    var displayArtistCount = 0
    var displayArtistParameterId: String?
    var displayArtistParameterName: String?

    func displayArtist(id: String, name: String) {
        displayArtistCount += 1
        displayArtistParameterId = id
        displayArtistParameterName = name
    }
}
