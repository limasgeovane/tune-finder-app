//
//  ArtistsRepository.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

import Foundation

protocol ArtistsRepositoryLogic {
    func fetchArtists(artistName: String, completion: @escaping (Result<ArtistsResponse, NSError>) -> Void)
}

struct ArtistsRepository: ArtistsRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchArtists(artistName: String, completion: @escaping (Result<ArtistsResponse, NSError>) -> Void) {
        network.requestTokenized(configuration: ArtistsConfiguration(artistName: artistName), completion: completion)
    }
}
