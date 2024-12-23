//
//  Albums.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Foundation

struct Albums: Codable {
    let items: [Items]
}

struct Items: Codable {
    let name: String
    let total_tracks: Int
    let release_date: String
    let images: [Images]
}

struct Images: Codable {
    let url: String?
}
