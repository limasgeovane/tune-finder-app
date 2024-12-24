//
//  Service.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Foundation
import Alamofire

class Service {
    static let tokenType = "Bearer"
    static let accessToken = "BQCNEiAkadSCfREWHOMJDv9yVQZJnZ5IrArdsNGEESLvLsIjDOHqnkZzTyOEoeRoE_Ob7_UOeRSKWeMlxqzK73tIYaDf-DAlMY7f0lWgGtkRAvpuHWg"
    
    private func getSpotifyAccessToken(artistName: String) {
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
                    self.getArtists(tokenType: token.token_type, accessToken: token.access_token, artistName: artistName) { artists in
                        print("Artistas obtidos com sucesso")
                    }
                }
            case .failure(let error):
                print("Erro ao obter o token: \(error)")
            }
        }
    }
    
    func getArtists(tokenType: String, accessToken: String, artistName: String, completion: @escaping ([Item]) -> Void) {
        let baseURLArtists: String = "https://api.spotify.com/v1/search"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) \(accessToken)"
        ]
        
        let parameters: [String: String] = [
            "q": artistName,
            "type": "artist",
        ]
        
        AF.request(baseURLArtists, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let artists = try? JSONDecoder().decode(Artists.self, from: data) {
                        completion(artists.artists.items)
                    } else {
                        print("Erro ao decodificar os dados dos artistas")
                    }
                case .failure(let error):
                    print("Erro ao buscar dados do artista: \(error)")
                    self.getSpotifyAccessToken(artistName: artistName)
                }
            }
    }
    
    func getAlbums(tokenType: String, accessToken: String, artistId: String,completion: @escaping ([Items]) -> Void) {
        let baseURLAlbums: String = "https://api.spotify.com/v1/artists/\(artistId)/albums"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) \(accessToken)"
        ]
        
        AF.request(baseURLAlbums, method: .get, headers: headers).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let albums = try? JSONDecoder().decode(Albums.self, from: data) {
                    completion(albums.items)
                } else {
                    print("Erro ao decodificar os dados dos álbuns")
                }
            case .failure(let error):
                print("Erro ao buscar álbuns: \(error)")
            }
        }
    }
}
