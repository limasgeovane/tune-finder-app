//
//  ArtistsViewSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import UIKit

class ArtistsViewSpy: UIView, ArtistsViewLogic {
    var artistsGetterCount = 0
    var stubbedArtists: [Artist] = []
    var artistsSetterCount = 0
    var invokedArtists: [Artist]?

    var artists: [Artist] {
        get {
            artistsGetterCount += 1
            return stubbedArtists
        }
        set {
            artistsSetterCount += 1
            invokedArtists = newValue
        }
    }


    var isShowLastArtistGetterCount = 0
    var stubbedIsShowLastArtist = false
    var isShowLastArtistSetterCount = 0
    var invokedIsShowLastArtist: Bool?

    var isShowLastArtist: Bool {
        get {
            isShowLastArtistGetterCount += 1
            return stubbedIsShowLastArtist
        }
        set {
            isShowLastArtistSetterCount += 1
            invokedIsShowLastArtist = newValue
        }
    }

    var delegateGetterCount = 0
    var stubbedDelegate: ArtistsViewDelegate?
    var delegateSetterCount = 0
    var invokedDelegate: ArtistsViewDelegate?

    var delegate: ArtistsViewDelegate? {
        get {
            delegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            delegateSetterCount += 1
            invokedDelegate = newValue
        }
    }

}
