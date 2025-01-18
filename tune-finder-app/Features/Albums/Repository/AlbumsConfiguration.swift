//
//  AlbumsConfiguration.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

struct AlbumsConfiguration: NetworkRequestConfigurator {
    private let artistId: String
    
    init(artistId: String) {
        self.artistId = artistId
    }
    
    var path: String {
        "/v1/artists/\(artistId)/albums"
    }
}
