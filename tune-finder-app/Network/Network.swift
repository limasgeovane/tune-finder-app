//
//  Network.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/12/24.
//

import Alamofire

class Network {
    func getArtists(artistName: String, completion: @escaping (Result<[Artists.Artist.Item], Error>) -> Void) {
        TokenManager.shared.getValidToken { result in
            switch result {
            case .success(let tokenData):
                let (tokenType, accessToken) = tokenData
                self.performGetArtists(tokenType: tokenType, accessToken: accessToken, artistName: artistName, completion: completion)
            case .failure(let error):
                completion(.failure(error))
                print("Erro ao obter token: \(error)")
            }
        }
    }
    
    private func performGetArtists(tokenType: String, accessToken: String, artistName: String, completion: @escaping (Result<[Artists.Artist.Item], Error>) -> Void) {
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
                        completion(.success(artists.artists.items))
                    } else {
                        print("Erro ao decodificar os dados dos artistas")
                        completion(.failure(NSError(domain: "Decodificação", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro ao decodificar os dados dos artistas"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    print("Erro ao buscar dados do artista: \(error)")
                }
            }
    }
    
    func getAlbums(artistId: String, completion: @escaping (Result<[Albums.Item], Error>) -> Void) {
        TokenManager.shared.getValidToken { result in
            switch result {
            case .success(let tokenData):
                let (tokenType, accessToken) = tokenData
                self.performGetAlbums(tokenType: tokenType, accessToken: accessToken, artistId: artistId, completion: completion)
            case .failure(let error):
                completion(.failure(error))
                print("Erro ao obter token: \(error)")
            }
        }
    }

    private func performGetAlbums(tokenType: String, accessToken: String, artistId: String, completion: @escaping (Result<[Albums.Item], Error>) -> Void) {
        let baseURLAlbums: String = "https://api.spotify.com/v1/artists/\(artistId)/albums"
        
        let headers: HTTPHeaders = [
            "Authorization": "\(tokenType) \(accessToken)"
        ]
    
        AF.request(baseURLAlbums, method: .get, headers: headers).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let albums = try? JSONDecoder().decode(Albums.self, from: data) {
                    completion(.success(albums.items))
                } else {
                    print("Erro ao decodificar os dados dos álbuns")
                    completion(.failure(NSError(domain: "Decodificação", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro ao decodificar os dados dos álbuns"])))
                }
            case .failure(let error):
                completion(.failure(error))
                print("Erro ao buscar álbuns: \(error)")
            }
        }
    }
}
