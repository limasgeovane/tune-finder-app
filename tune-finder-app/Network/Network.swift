//
//  NewNetwork.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

import Foundation

protocol NetworkLogic {
    func requestTokenized<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, NSError>) -> Void
    )
}

class Network: NetworkLogic {
    private var spotifyTokenExpirationDate = Date()
    private var spotifyToken: SpotifyToken?
    
    private let networkRequest: NetworkRequester
    private let networkDeserialization: NetworkDeserialization
    
    init(
        networkRequest: NetworkRequester = AlamofireNetworkRequest(),
        networkDeserialization: NetworkDeserialization = NetworkDeserialization()
    ) {
        self.networkRequest = networkRequest
        self.networkDeserialization = networkDeserialization
    }
    
    func requestTokenized<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, NSError>) -> Void
    ) {
        if let spotifyToken, spotifyTokenExpirationDate > Date() {
            var hearders: [String:String] = configuration.hearders
            hearders["Authorization"] = "\(spotifyToken.tokenType) \(spotifyToken.accessToken)"
            request(configuration: configuration, customHeaders: hearders, completion: completion)
        } else {
            request(configuration: SpotifyTokenConfiguration()) { [weak self] (result: Result<SpotifyToken, NSError>) in
                switch result {
                case .success(let token):
                    self?.spotifyTokenExpirationDate = Date().addingTimeInterval(TimeInterval(token.expiresIn))
                    self?.spotifyToken = token
                    self?.requestTokenized(configuration: configuration, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func request<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        customHeaders: [String: String]? = nil,
        completion: @escaping (Result<T, NSError>) -> Void
    ) {
        networkRequest.request(
            url: configuration.baseURL.rawValue + configuration.path,
            method: configuration.method,
            parameters: configuration.parameters,
            encoding: configuration.enconding,
            headers: customHeaders ?? configuration.hearders
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let decodedData = try networkDeserialization.decode(data: data) as T
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error as NSError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
