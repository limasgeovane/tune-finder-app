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
                    self.getArtists(tokenType: token.token_type, accessToken: token.access_token, artistName: "Jaloo")
                }
            case .failure(let error):
                print("Erro ao obter o token: \(error)")
            }
        }
    }
    
    func getArtists(tokenType: String, accessToken: String, artistName: String) {
        
        let baseURLArtists: String = "https://api.spotify.com/v1/search"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) \(accessToken)"
        ]
        
        let parameters: [String: String] = [
            "q": artistName,
            "type": "artist",
            "limit": "10"
        ]
        
        AF.request(baseURLArtists, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let artists = try? JSONDecoder().decode(ArtistResponse.self, from: data) {
                        for artists in artists.artists.items {
                            print("Id: \(artists.id)")
                            print("Nome do artista: \(artists.name)")
                            print("Gêneros do artista: \(artists.genres.joined(separator: ","))")
                            print("ImagemUrl do artista: \(artists.images.first?.url ?? "")")
                        }
                        self.getAlbums(tokenType: tokenType, accessToken: accessToken, artistId: "1rdXEdH8SRIqbuTbzQzd93")
                    } else {
                        print("Erro ao decodificar os dados dos artistas")
                    }
                case .failure(let error):
                    print("Erro ao buscar dados do artista: \(error)")
                    self.getSpotifyAccessToken()
                }
            }
    }
    
    func getAlbums(tokenType: String, accessToken: String, artistId: String) {
        let baseURLAlbums: String = "https://api.spotify.com/v1/artists/\(artistId)/albums"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) \(accessToken)"
        ]
        
        AF.request(baseURLAlbums, method: .get, headers: headers).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let albums = try? JSONDecoder().decode(AlbumsResponse.self, from: data) {
                    for albums in albums.items {
                        print("Imagem do album: \(albums.images.first?.url ?? "")")
                        print("Nome do album: \(albums.name)")
                        print("Data de lançamento: \(albums.release_date)")
                        print("Total de músicas: \(albums.total_tracks)")
                    }
                } else {
                    print("Erro ao decodificar os dados dos álbuns")
                }
                
            case .failure(let error):
                print("Erro ao buscar álbuns: \(error)")
            }
        }
    }
}
