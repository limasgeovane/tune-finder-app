//
//  ArtistsViewModelTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

import XCTest
@testable import tune_finder_app

final class ArtistsViewModelTests: XCTestCase {
    let repositorySpy = ArtistsRepositorySpy()
    let displaySpy = ListArtistsDisplaySpy()
    
    lazy var sut: ArtistsViewModel = {
        let viewModel = ArtistsViewModel(
            repository: repositorySpy,
            artistName: "Roberto Carlos"
        )
        viewModel.display = displaySpy
        
        return viewModel
    }()
    
    func test_fetchArtists_givenSuccess_shouldDisplayArtists() {
        let successStubbed: Result<ArtistsResponse, NSError> = .success(.fixture())
        repositorySpy.stubbedFetchArtistsCompletionResult = successStubbed
        
        sut.fetchArtists()
        
        XCTAssertEqual(repositorySpy.fetchArtistsCount, 1)
        XCTAssertEqual(repositorySpy.fetchArtistsArtistName, "Roberto Carlos")
        XCTAssertEqual(displaySpy.displayArtistsCount, 1)
        XCTAssertEqual(displaySpy.displayArtistsParameterArtists.first, .fixture())
    }
    
    func test_selectArtist_shouldDisplayArtist() {
        let successStubbed: Result<ArtistsResponse, NSError> = .success(.fixture())
        repositorySpy.stubbedFetchArtistsCompletionResult = successStubbed
        sut.fetchArtists()
        
        sut.selectArtist(indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(displaySpy.displayArtistCount, 1)
        XCTAssertEqual(displaySpy.displayArtistParameterId, "123")
        XCTAssertEqual(displaySpy.displayArtistParameterName, "Roberto Carlos")
    }
}
