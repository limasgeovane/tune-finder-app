//
//  AlbumsRepository.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

import Foundation

protocol AlbumsRepositoryLogic {
    func fetchAlbums(artistId: String, completion: @escaping (Result<AlbumsResponse, NSError>) -> Void)
}

struct AlbumsRepository: AlbumsRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchAlbums(artistId: String, completion: @escaping (Result<AlbumsResponse, NSError>) -> Void) {
        network.requestTokenized(configuration: AlbumsConfiguration(artistId: artistId), completion: completion)
    }
}
