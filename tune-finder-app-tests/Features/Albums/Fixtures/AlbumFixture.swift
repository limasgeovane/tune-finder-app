//
//  AlbumFixture.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app

extension Album {
    static func fixture(
        image: String? = "https://example.com",
        name: String = "Roberto Carlos",
        releaseDate: String = "01/02/2009",
        totalTracks: Int = 98
    ) -> Self {
        .init(image: image, name: name, releaseDate: releaseDate, totalTracks: totalTracks)
    }
}
