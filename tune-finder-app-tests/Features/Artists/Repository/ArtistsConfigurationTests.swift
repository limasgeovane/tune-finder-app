//
//  ArtistsConfigurationTests.swift
//  tune-finder-app-tests
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

import XCTest
@testable import tune_finder_app

final class ArtistsConfigurationTests: XCTestCase {
    var sut = ArtistsConfiguration(artistName: "Maria Bethânia")

    func test_path_shouldCorrectPath() {
        XCTAssertEqual(sut.path, "/v1/search")
    }
    
    func test_method_shouldBeGet() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_parameters_shouldCorrectParameters() {
        XCTAssertEqual(sut.parameters["q"] as? String, "Maria Bethânia")
        XCTAssertEqual(sut.parameters["type"] as? String, "artist")
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
