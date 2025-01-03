//
//  SpotfyTokenResponse.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

struct SpotfyTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
