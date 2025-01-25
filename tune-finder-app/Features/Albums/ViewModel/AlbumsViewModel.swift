//
//  AlbumsViewModel.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 20/01/25.
//

import Foundation

protocol AlbumsViewModelLogic {
    var display: ListAlbumsDisplayable? { get set }
    func fetchAlbums()
}

class AlbumsViewModel: AlbumsViewModelLogic {
    weak var display: ListAlbumsDisplayable?
    private var albumsResponse: AlbumsResponse?
    
    private let repository: AlbumsRepositoryLogic
    private let artistId: String
    private let artistName: String
 
    init(repository: AlbumsRepositoryLogic, artistId: String, artistName: String) {
        self.repository = repository
        self.artistId = artistId
        self.artistName = artistName
    }
    
    func fetchAlbums() {
        repository.fetchAlbums(artistId: artistId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let albumsResponse):
                self.albumsResponse = albumsResponse
                let albums = toAlbums(response: albumsResponse)
                display?.displayAlbums(artistName: "Álbuns de \(self.artistName)", albums: albums)
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    private func toAlbums(response: AlbumsResponse) -> [Album] {
        return response.items.map {
            .init(
                image: $0.images.first?.url,
                name: $0.name,
                releaseDate: $0.releaseDate,
                totalTracks: $0.totalTracks
            )
        }
    }
}
