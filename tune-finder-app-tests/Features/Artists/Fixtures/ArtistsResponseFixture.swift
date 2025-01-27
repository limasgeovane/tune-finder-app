//
//  ArtistsResponseFixture.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app

extension ArtistsResponse {
    static func fixture(artists: Artist = .fixture()) -> Self {
        .init(artists: artists)
    }
}

extension ArtistsResponse.Artist {
    static func fixture(items: [Item] = [.fixture()]) -> Self {
        .init(items: items)
    }
}

extension ArtistsResponse.Artist.Item {
    static func fixture(
        images: [Image] = [.fixture()],
        name: String = "Roberto Carlos",
        genres: [String]? = ["rock", "mpb"],
        id: String = "123"
    ) -> Self {
        .init(
            images: images,
            name: name,
            genres: genres,
            id: id
        )
    }
}

extension ArtistsResponse.Artist.Item.Image {
    static func fixture(url: String? = "https://www.google.com.br") -> Self {
        .init(url: url)
    }
}
