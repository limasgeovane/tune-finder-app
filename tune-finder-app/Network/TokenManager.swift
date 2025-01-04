//
//  TokenManager.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 29/12/24.
//

import Alamofire

class TokenManager {
    static let shared = TokenManager()
    private var accessToken: String?
    private var tokenType: String?
    private var tokenExpirationDate: Date?
    private let tokenQueue = DispatchQueue(label: "tokenQueue", qos: .userInitiated)
    private var tokenFetchWorkItem: DispatchWorkItem?
    private init() { }
    
    private func getSpotifyAccessToken(completion: @escaping (Result<(String, String), Error>) -> Void) {
        let baseURL: String = "https://accounts.spotify.com/api/token"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let body: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": "bc63eaddf98c4aab9fdc26922de70a57",
            "client_secret": "3b8e3edb8b1e46c28e138d6fc677a7ea"
        ]
        
        AF.request(baseURL, method: .post, parameters: body, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let token = try? JSONDecoder().decode(SpotifyTokenResponse.self, from: data) {
                        let expirationTime = Date().addingTimeInterval(TimeInterval(token.expiresIn))
                        self.accessToken = token.accessToken
                        self.tokenType = token.tokenType
                        self.tokenExpirationDate = expirationTime
                        completion(.success((token.tokenType, token.accessToken)))
                    } else {
                        completion(.failure(NSError(domain: "Decodificação", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro ao decodificar o token"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getValidToken(completion: @escaping (Result<(String, String), Error>) -> Void) {
        tokenQueue.async {
            if let token = self.accessToken,
               let tokenType = self.tokenType,
               let expirationDate = self.tokenExpirationDate,
               expirationDate > Date() {
                completion(.success((tokenType, token)))
            } else {
                if let workItem = self.tokenFetchWorkItem {
                    workItem.notify(queue: self.tokenQueue) {
                        self.getValidToken(completion: completion)
                    }
                    return
                }
                let workItem = DispatchWorkItem {
                    self.getSpotifyAccessToken { result in
                        switch result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                        self.tokenFetchWorkItem = nil
                    }
                }
                self.tokenFetchWorkItem = workItem
                self.tokenQueue.async(execute: workItem)
            }
        }
    }
}
