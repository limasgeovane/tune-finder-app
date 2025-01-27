//
//  Untitled.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app
import Foundation

class ArtistsRepositorySpy: ArtistsRepositoryLogic {
    var fetchArtistsCount = 0
    var fetchArtistsArtistName: String?
    var stubbedFetchArtistsCompletionResult: Result<ArtistsResponse, NSError>?

    func fetchArtists(artistName: String, completion: @escaping (Result<ArtistsResponse, NSError>) -> Void) {
        fetchArtistsCount += 1
        fetchArtistsArtistName = artistName
        if let result = stubbedFetchArtistsCompletionResult {
            completion(result)
        }
    }
}
