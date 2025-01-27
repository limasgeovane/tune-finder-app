//
//  AlbumsResponseFixture.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

@testable import tune_finder_app

extension AlbumsResponse {
    static func fixture(items: [Item] = [.fixture()]) -> Self {
        .init(items: items)
    }
}

extension AlbumsResponse.Item {
    static func fixture(
        name: String = "Roberto Carlos",
        totalTracks: Int = 98,
        releaseDate: String = "01/02/2009",
        images: [Image] = [.fixture()]
    ) -> Self {
        .init(
            name: name,
            totalTracks: totalTracks,
            releaseDate: releaseDate,
            images: images
        )
    }
}

extension AlbumsResponse.Item.Image {
    static func fixture(url: String = "https://example.com") -> Self {
        .init(url: url)
    }
}
