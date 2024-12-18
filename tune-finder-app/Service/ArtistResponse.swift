//
//  ArtistResponse.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Foundation

struct ArtistResponse: Codable {
    let id: String
    let name: String
    let genres: [String]
    let images: [Image]
}

struct Image: Codable {
    let url: String
}
