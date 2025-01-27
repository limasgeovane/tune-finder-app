//
//  ArtistFixture.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app

extension Artist {
    static func fixture(
        image: String = "https://www.google.com.br",
        name: String = "Roberto Carlos",
        genres: String = "rock, mpb"
    ) -> Self {
        .init(image: image, name: name, genres: genres)
    }
}
