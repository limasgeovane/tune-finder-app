//
//  AlbumsRepositoryTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

import XCTest
@testable import tune_finder_app

final class AlbumsRepositoryTests: XCTestCase {
    let networkSpy = NetworkSpy()
    lazy var sut = AlbumsRepository(network: networkSpy)
    
    func test_fetchAlbums_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<AlbumsResponse, NSError> = .success(.fixture())
        networkSpy.stubbedRequestTokenizedCompletion = successStubbed
        
        sut.fetchAlbums(artistId: "304") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, .fixture())
                XCTAssertEqual(self.networkSpy.requestTokenizedCount, 1)
            case .failure:
                XCTFail("Should be a success")
            }
        }
    }
    
    func test_fetchArtists_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<ArtistsResponse, NSError> = .failure(.fixture())
        networkSpy.stubbedRequestTokenizedCompletion = failureStubbed
        
        sut.fetchAlbums(artistId: "304") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(self.networkSpy.requestTokenizedCount, 1)
            case .success:
                XCTFail("Should be a error")
            }
        }
    }
}
