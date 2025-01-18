//
//  NetworkRequest.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/01/25.
//

import Alamofire

struct AlamofireNetworkRequest: NetworkRequester {
    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, NSError>) -> Void
    ) {
        AF.request(
            url,
            method: toHTTPMethod(method: method),
            parameters: parameters,
            encoding: toParameterEnconding(encoding: encoding),
            headers: toHTTPHeaders(headers: headers)
        )
        .validate()
        .response { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(toNSError(afError: error)))
            }
        }
    }
    
    private func toHTTPMethod(method: NetworkMethod) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    private func toHTTPHeaders(headers: [String: String]?) -> HTTPHeaders? {
        guard let headers else {
            return nil
        }
        
        var httpHeaders = HTTPHeaders()
        
        headers.forEach { (key: String, value: String) in
            httpHeaders.add(name: key, value: value)
        }
        
        return httpHeaders
    }
    
    private func toParameterEnconding(encoding: NetworkParameterEncoding) -> ParameterEncoding {
        switch encoding {
        case .default:
            return URLEncoding.default
        case .httpBody:
            return URLEncoding.default
        }
    }
    
    private func toNSError(afError: AFError) -> NSError {
        let errorDomain = "com.alamofire.error"
        let errorCode = afError.responseCode ?? -1
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: afError.errorDescription ?? "Unknown error",
            "AFError": afError
        ]

        return NSError(domain: errorDomain, code: errorCode, userInfo: userInfo)
    }
}
