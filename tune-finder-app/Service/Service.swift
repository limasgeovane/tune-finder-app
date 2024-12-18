//
//  Service.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Foundation
import Alamofire

class Service {
    func getSpotifyAccessToken() {
        let baseURL: String = "https://accounts.spotify.com/api/token"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let body: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": "bc63eaddf98c4aab9fdc26922de70a57",
            "client_secret": "3b8e3edb8b1e46c28e138d6fc677a7ea"
        ]
        
        AF.request(baseURL, method: .post, parameters: body, encoding: URLEncoding.default, headers: headers).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let token = try? JSONDecoder().decode(SpotfyTokenResponse.self, from: data) {
                    print("Token: \(token.access_token)")
                    print(token.token_type)
                    self.getArtists(tokenType: token.token_type, accessToken: token.access_token)
                }
            case .failure(let error):
                print("Erro ao obter o token: \(error)")
            }
        }
    }
    
    private func getArtists(tokenType: String, accessToken: String) {
        let baseURLArtists: String = "https://api.spotify.com/v1/artists/0rSTXALHu0EKAawPLBdODH"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) " + "\(accessToken)"
        ]
        
        AF.request(baseURLArtists, method: .get, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let artist = try? JSONDecoder().decode(ArtistResponse.self, from: data) {
                        print("Nome do artista: \(artist.name)")
                        print("Gêneros do artista: \(artist.genres.joined(separator: ","))")
                        print("ImagemUrl do artista: \(artist.images.first?.url ?? "")")
                        self.getAlbums(tokenType: tokenType, accessToken: accessToken)
                    }
                case .failure(let error):
                    print("Erro ao buscar dados do artista: \(error)")
                }
            }
    }
    
    private func getAlbums(tokenType: String, accessToken: String) {
        let baseURLAlbums: String = "https://api.spotify.com/v1/artists/0rSTXALHu0EKAawPLBdODH/albums"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) " + "\(accessToken)"
        ]
        
        AF.request(baseURLAlbums, method: .get, headers: headers).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let albums = try? JSONDecoder().decode(AlbumsResponse.self, from: data) {
                    print(albums)
                }
            case .failure(let error):
                print("Erro ao buscar álbuns: \(error)")
            }
        }
    }
}
