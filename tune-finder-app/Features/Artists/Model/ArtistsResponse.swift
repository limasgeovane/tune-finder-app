//
//  ArtistsResponse.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

struct ArtistsResponse: Decodable, Equatable {
    let artists: Artist
    
    struct Artist: Decodable, Equatable {
        let items: [Item]
        
        struct Item: Decodable, Equatable {
            let images: [Image]
            let name: String
            let genres: [String]?
            let id: String
            
            struct Image: Decodable, Equatable {
                let url: String?
            }
        }
    }
}
