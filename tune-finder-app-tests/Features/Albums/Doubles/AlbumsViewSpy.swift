//
//  AlbumsViewSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//


@testable import tune_finder_app
import UIKit

class AlbumsViewSpy: UIView, AlbumsViewLogic {
    var artistNameGetterCount = 0
    var stubbedArtistName: String = ""
    var artistNameSetterCount = 0
    var invokedArtistName: String?

    var artistName: String {
        get {
            artistNameGetterCount += 1
            return stubbedArtistName
        }
        set {
            artistNameSetterCount += 1
            invokedArtistName = newValue
        }
    }
    
    var albumsGetterCount = 0
    var stubbedAlbums: [Album] = []
    var albumsSetterCount = 0
    var invokedAlbums: [Album]?

    var albums: [Album] {
        get {
            albumsGetterCount += 1
            return stubbedAlbums
        }
        set {
            albumsSetterCount += 1
            invokedAlbums = newValue
        }
    }
}
