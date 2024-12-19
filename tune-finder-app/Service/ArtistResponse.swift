//
//  ArtistResponse.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Foundation

struct ArtistResponse: Codable {
    let artists: Artists
}

struct Artists: Codable {
    let items: [Item]
}

struct Item: Codable {
    let images: [Image]
    let name: String
    let genres: [String]
    let id: String
}

struct Image: Codable {
    let url: String
}
