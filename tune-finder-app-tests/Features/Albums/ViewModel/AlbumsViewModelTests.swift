//
//  AlbumsViewModelTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

import XCTest
@testable import tune_finder_app

final class AlbumsViewModelTests: XCTestCase {
    let repositorySpy = AlbumsRepositorySpy()
    let displaySpy = ListAlbumsDisplaySpy()
    
    lazy var sut: AlbumsViewModel = {
        let viewModel = AlbumsViewModel(
            repository: repositorySpy,
            artistId: "405",
            artistName: "Maria Rita"
        )
        viewModel.display = displaySpy
        
        return viewModel
    }()
    
    func test_fetchAlbums_givenSuccess_shouldDisplayAlbums() {
        let successStubbed: Result<AlbumsResponse, NSError> = .success(.fixture())
        repositorySpy.stubbedFetchAlbumsCompletionResult = successStubbed
        
        sut.fetchAlbums()
        
        XCTAssertEqual(repositorySpy.fetchAlbumsCount, 1)
        XCTAssertEqual(repositorySpy.fetchAlbumsParameterArtistId, "405")
        XCTAssertEqual(displaySpy.displayAlbumsCount, 1)
        XCTAssertEqual(displaySpy.displayAlbumsParameterArtistName, "Álbuns de Maria Rita")
        XCTAssertEqual(displaySpy.displayAlbumsParameterArtistAlbums.first, .fixture())
    }
}
