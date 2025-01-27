//
//  AlbumsConfigurationTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

import XCTest
@testable import tune_finder_app

final class AlbumsConfigurationTests: XCTestCase {
    var sut = AlbumsConfiguration(artistId: "304")

    func test_path_shouldCorrectPath() {
        XCTAssertEqual(sut.path, "/v1/artists/304/albums")
    }
    
    func test_method_shouldBeGet() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_parameters_shouldCorrectParameters() {
        XCTAssertTrue(sut.parameters.isEmpty)
    }
    
    func test_baseURL_shouldBeSpotify() {
        XCTAssertEqual(sut.baseURL, .spotify)
    }
    
    func test_encoding_shouldBeDefault() {
        XCTAssertEqual(sut.enconding, .default)
    }
    
    func test_headers_shouldBeEmpty() {
        XCTAssertTrue(sut.hearders.isEmpty)
    }
}
