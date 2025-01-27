//
//  ArtistsViewModel.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 19/01/25.
//

import Foundation

protocol ArtistsViewModelLogic {
    var display: ListArtistsDisplayable? { get set }
    func fetchArtists()
    func fetchArtists(artistName: String)
    func selectArtist(indexPath: IndexPath)
}

class ArtistsViewModel: ArtistsViewModelLogic {
    weak var display: ListArtistsDisplayable?
    private var artistsResponse: ArtistsResponse?
    
    private let repository: ArtistsRepositoryLogic
    private var artistName: String
    private let isShowLastArtist: Bool
    
    init(
        repository: ArtistsRepositoryLogic,
        artistName: String,
        isShowLastArtist: Bool
    ) {
        self.repository = repository
        self.artistName = artistName
        self.isShowLastArtist = isShowLastArtist
    }
    
    func fetchArtists() {
        fetchArtists(artistName: artistName)
    }
    
    func fetchArtists(artistName: String) {
        saveLastArtistSearched(artistName: artistName)
        
        repository.fetchArtists(artistName: artistName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let artistsResponse):
                self.artistsResponse = artistsResponse
                let artists = toArtists(response: artistsResponse)
                display?.displayArtists(
                    isShowLastArtist: self.isShowLastArtist,
                    artists: artists
                )
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    func selectArtist(indexPath: IndexPath) {
        guard let artists = artistsResponse?.artists.items else { return }
        
        let id = artists[indexPath.row].id
        let name = artists[indexPath.row].name
        display?.displayArtist(id: id, name: name)
    }
    
    private func toArtists(response: ArtistsResponse) -> [Artist] {
        return response.artists.items.map {
            .init(
                image: $0.images.first?.url,
                name: $0.name,
                genres: $0.genres?.reduce("") { $0.isEmpty ? $1 : $0 + ", " + $1 } ?? "-"
            )
        }
    }
    
    private func saveLastArtistSearched(artistName: String) {
        UserDefaults.standard.set(artistName, forKey: "lastArtistSearched")
    }
}
