//
//  ArtistsConfigurator.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

struct ArtistsConfiguration: NetworkRequestConfigurator, Equatable {
    private let artistName: String
    
    init(artistName: String) {
        self.artistName = artistName
    }
    
    var path: String {
        "/v1/search"
    }
    
    var parameters: [String: Any] {
        [
            "q": artistName,
            "type": "artist",
        ]
    }
}
