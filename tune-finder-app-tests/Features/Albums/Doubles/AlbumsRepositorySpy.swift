//
//  AlbumsRepositorySpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app
import Foundation

class AlbumsRepositorySpy: AlbumsRepositoryLogic {
    var fetchAlbumsCount = 0
    var fetchAlbumsParameterArtistId: String?
    var stubbedFetchAlbumsCompletionResult: Result<AlbumsResponse, NSError>?

    func fetchAlbums(artistId: String, completion: @escaping (Result<AlbumsResponse, NSError>) -> Void) {
        fetchAlbumsCount += 1
        fetchAlbumsParameterArtistId = artistId
        if let result = stubbedFetchAlbumsCompletionResult {
            completion(result)
        }
    }
}
