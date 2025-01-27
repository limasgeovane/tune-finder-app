//
//  AlbumsViewModelSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import Foundation

class AlbumsViewModelSpy: AlbumsViewModelLogic {
    var displayGetterCount = 0
    var stubbedDisplay: AlbumsDisplayable?
    var displaySetterCount = 0
    var invokedDisplay: AlbumsDisplayable?

    var display: AlbumsDisplayable? {
        get {
            displayGetterCount += 1
            return stubbedDisplay
        }
        set {
            displaySetterCount += 1
            invokedDisplay = newValue
        }
    }

    var invokedFetchAlbumsCount = 0

    func fetchAlbums() {
        invokedFetchAlbumsCount += 1
    }
}
