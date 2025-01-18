//
//  NetworkDeserialization.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 18/01/25.
//

import Foundation

protocol NetworkDeserializable {
    func decode<T: Decodable>(data: Data?) throws -> T
}

struct NetworkDeserialization: NetworkDeserializable {
    func decode<T: Decodable>(data: Data?) throws -> T {
        guard let data else { throw NSError(domain: "Invalid Data", code: 0) }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NSError(domain: "Can't decode", code: 0)
        }
    }
}
