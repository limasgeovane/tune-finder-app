//
//  AlbumsResponse.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

struct AlbumsResponse: Decodable, Equatable {
    let items: [Item]
    
    struct Item: Decodable, Equatable {
        let name: String
        let totalTracks: Int
        let releaseDate: String
        let images: [Image]
        
        struct Image: Decodable, Equatable {
            let url: String?
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case totalTracks = "total_tracks"
            case releaseDate = "release_date"
            case images
        }
    }
}
