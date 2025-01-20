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
    
    private func navigationToArtist(artistName: String, isShowLastArtist: Bool) {
        let artistsCoordinator = ArtistsCoordinator(navigationController: navigationController, artistName: artistName, isShowLastArtist: isShowLastArtist)
        self.artistsCoordinator = artistsCoordinator
        artistsCoordinator.start()
    }
}

extension StartAppCoordinator: SplashScreenDelegate {
    func splashScreenDidFinishAnimation() {
        let isSearchedArtistBefore = UserDefaults.standard.bool(forKey: "isSearchedBefore")
        let lastArtistNameSearched = UserDefaults.standard.string(forKey: "lastArtistSearched")
        
        if isSearchedArtistBefore {
            navigationToArtist(artistName: lastArtistNameSearched ?? "", isShowLastArtist: true)
        } else {
            navigationToHome()
        }
    }
}

extension StartAppCoordinator: HomeViewControllerDelegate {
    func homeDidSearchArtist(artistName: String) {
        UserDefaults.standard.set(true, forKey: "isSearchedBefore")
        UserDefaults.standard.set(artistName, forKey: "lastArtistSearched")
        navigationToArtist(artistName: artistName, isShowLastArtist: false)
    }
}
