//
//  ArtistsViewControllerTests.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 26/01/25.
//

import XCTest
@testable import tune_finder_app

final class ArtistsViewControllerTests: XCTestCase {
    let contentViewSpy = ArtistsViewSpy()
    let viewModelSpy = ArtistsViewModelSpy()
    let delegateSpy = ArtistsViewControllerDelegateSpy()
    
    lazy var sut = ArtistsViewController(
        contentView: contentViewSpy,
        viewModel: viewModelSpy,
        delegate: delegateSpy
    )
    
    func test_loadView_shouldSetView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is ArtistsViewLogic)
    }
    
    func test_viewDidLoad_shouldCallFetchArtists() {
        sut.viewDidLoad()
        XCTAssertEqual(viewModelSpy.displaySetterCount, 1)
        XCTAssertNotNil(viewModelSpy.invokedDisplay)
        XCTAssertEqual(contentViewSpy.delegateSetterCount, 1)
        XCTAssertNotNil(contentViewSpy.invokedDelegate)
        XCTAssertEqual(viewModelSpy.fetchArtistsCount, 1)
        XCTAssertEqual(viewModelSpy.fetchArtistsCount, 1)
        XCTAssertEqual(sut.title, "Artistas")
    }
    
    func test_displayArtists_shouldSetArtists() {
        sut.displayArtists(isShowLastArtist: true, artists: [.fixture()])
        
        XCTAssertEqual(contentViewSpy.artistsSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedArtists, [.fixture()])
        XCTAssertEqual(contentViewSpy.isShowLastArtistSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedIsShowLastArtist, true)
    }
    
    func test_displayArtist_shouldCallDelegate() {
        sut.displayArtist(id: "203", name: "Xuxa")
        
        XCTAssertEqual(delegateSpy.ArtistsDidSelectArtistCount, 1)
        XCTAssertEqual(delegateSpy.ArtistsDidSelectArtistParameterArtistId, "203")
        XCTAssertEqual(delegateSpy.ArtistsDidSelectArtistParameterArtistName, "Xuxa")
    }
    
    func test_didSelectArtist_shouldSelectArtist() {
        sut.didSelectArtist(indexPath: IndexPath())
        
        XCTAssertEqual(viewModelSpy.selectArtistCount, 1)
        XCTAssertEqual(viewModelSpy.selectArtistParameterIndexPath, IndexPath())
    }
    
    func test_searchArtist_shouldFetchArtists() {
        sut.searchArtist(artistName: "Vanessa")
        
        XCTAssertEqual(viewModelSpy.fetchArtistsArtistNameCount, 1)
        XCTAssertEqual(viewModelSpy.fetchArtistsArtistNameParameterArtistName, "Vanessa")
    }
}
