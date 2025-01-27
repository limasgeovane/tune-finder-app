//
//  ListAlbumsViewControllerTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

import XCTest
@testable import tune_finder_app

final class ListAlbumsViewControllerTests: XCTestCase {
    let contentViewSpy = ListAlbumsViewSpy()
    let viewModelSpy = AlbumsViewModelSpy()
    
    lazy var sut = ListAlbumsViewController(
        contentView: contentViewSpy,
        viewModel: viewModelSpy
    )
    
    func test_loadView_shouldSetView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is ListAlbumsViewLogic)
    }
    
    func test_viewDidLoad_shouldCallFetchArtists() {
        sut.viewDidLoad()
        XCTAssertEqual(viewModelSpy.displaySetterCount, 1)
        XCTAssertNotNil(viewModelSpy.invokedDisplay)
        XCTAssertEqual(viewModelSpy.invokedFetchAlbumsCount, 1)
    }
    
    func test_displayAlbums_shouldSetContentView() {
        sut.displayAlbums(artistName: "Maria Rita", albums: [.fixture()])
        
        XCTAssertEqual(contentViewSpy.artistNameSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedArtistName, "Maria Rita")
        XCTAssertEqual(contentViewSpy.albumsSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedAlbums, [.fixture()])
    }
}
