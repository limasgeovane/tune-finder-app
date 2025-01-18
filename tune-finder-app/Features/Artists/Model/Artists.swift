//
//  Artists.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

struct Artists: Decodable {
    let artists: Artist
    
    struct Artist: Decodable {
        let items: [Item]
        
        struct Item: Decodable {
            let images: [Image]
            let name: String
            let genres: [String]?
            let id: String
            
            struct Image: Decodable {
                let url: String?
            }
        }
    }
}
