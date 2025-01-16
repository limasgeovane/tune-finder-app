//
//  StartAppCoordinator.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 14/01/25.
//

import UIKit

class StartAppCoordinator {
    private var navigationController = UINavigationController()
    private var artistsCoordinator: ArtistsCoordinator?
    
    func start() -> UINavigationController {
        let splashScreenView = SplashScreenView()
        let splashScreenViewController = SplashScreenViewController(contentView: splashScreenView, delegate: self)
        navigationController = UINavigationController(rootViewController: splashScreenViewController)
        return navigationController
    }
    
    private func navigationToHome() {
        let homeView = HomeView()
        let homeViewController = HomeViewController(contentView: homeView, delegate: self)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func navigationToArtist(artists: [Artists.Artist.Item] = [], artistName: String = "") {
        let artistsCoordinator = ArtistsCoordinator(navigationController: navigationController, artists: artists, artistName: artistName)
        self.artistsCoordinator = artistsCoordinator
        artistsCoordinator.start()
    }
}

extension StartAppCoordinator: SplashScreenDelegate {
    func splashScreenDidFinishAnimation() {
        let isSearchedArtistBefore = UserDefaults.standard.bool(forKey: "isSearchedBefore")
        
        if isSearchedArtistBefore {
            navigationToArtist()
        } else {
            navigationToHome()
        }
    }
}

extension StartAppCoordinator: HomeViewControllerDelegate {
    func homeDidSearchArtist(artists: [Artists.Artist.Item], artistName: String) {
        UserDefaults.standard.set(true, forKey: "isSearchedBefore")
        UserDefaults.standard.set(artistName, forKey: "lastArtistSearched")
        navigationToArtist(artists: artists, artistName: artistName)
    }
}
