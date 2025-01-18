//
//  SpotifyTokenConfiguration.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

struct SpotifyTokenConfiguration: NetworkRequestConfigurator {
    var baseURL: NetworkBaseURL {
        .spotifyAccounts
    }
    
    var path: String {
        "/api/token"
    }
    
    var method: NetworkMethod {
        .post
    }
    
    var parameters: [String : Any] {
        [
            "grant_type": "client_credentials",
            "client_id": "bc63eaddf98c4aab9fdc26922de70a57",
            "client_secret": "3b8e3edb8b1e46c28e138d6fc677a7ea"
        ]
    }
    
    var hearders: [String : String] {
        [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
