//
//  NetworkSpy.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app
import Foundation

class NetworkSpy: NetworkLogic {
    var requestTokenizedCount = 0
    var stubbedRequestTokenizedCompletion: Any?

    func requestTokenized<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, NSError>) -> Void
    ) {
        requestTokenizedCount += 1
        if let result = stubbedRequestTokenizedCompletion as? Result<T, NSError> {
            completion(result)
        }
    }
}
