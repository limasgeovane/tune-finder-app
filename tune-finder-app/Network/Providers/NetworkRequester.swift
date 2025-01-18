//
//  NetworkRequestProvider.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/01/25.
//

import Foundation

protocol NetworkRequester {
    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, NSError>) -> Void
    )
}
