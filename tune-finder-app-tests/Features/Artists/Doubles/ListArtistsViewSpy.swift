//
//  ListArtistsViewSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import UIKit

class ListArtistsViewSpy: UIView, ListArtistsViewLogic {
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
    
    var delegateGetterCount = 0
    var stubbedDelegate: ListArtistsViewDelegate?
    var delegateSetterCount = 0
    var invokedDelegate: ListArtistsViewDelegate?

    var delegate: ListArtistsViewDelegate? {
        get {
            delegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            delegateSetterCount += 1
            invokedDelegate = newValue
        }
    }

    var setupLastSearchStateCount = 0
    var setupLastSearchStateParameterIsShowLastArtist: Bool = false
    
    func setupLastSearchState(isShowLastArtist: Bool) {
        setupLastSearchStateCount += 1
        setupLastSearchStateParameterIsShowLastArtist = isShowLastArtist
    }
}
