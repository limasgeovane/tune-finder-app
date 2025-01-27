//
//  AlbumsDisplaySpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app

class AlbumsDisplaySpy: AlbumsDisplayable {
    var displayAlbumsCount = 0
    var displayAlbumsParameterArtistName: String?
    var displayAlbumsParameterArtistAlbums: [Album] = []

    func displayAlbums(artistName: String, albums: [Album]) {
        displayAlbumsCount += 1
        displayAlbumsParameterArtistName = artistName
        displayAlbumsParameterArtistAlbums = albums
    }
}
