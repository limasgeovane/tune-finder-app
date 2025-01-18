//
//  SpotifyToken.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

struct SpotifyToken: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
