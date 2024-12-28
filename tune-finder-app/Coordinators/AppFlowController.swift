//
//  AppFlowController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class AppFlowController: SplashFlowDelegate{
    private var navigationController: UINavigationController?
    private let userDefaults = UserDefaults.standard
    
    func startNavigate() -> UINavigationController? {
        let splashScreenView = SplashScreenView()
        let splashScreenViewController = SplashScreenViewController(contentView: splashScreenView, delegate: self)
        self.navigationController = UINavigationController(rootViewController: splashScreenViewController)
        return navigationController
    }
    
    func navigateToHomeViewController() {
        let homeView = HomeView()
        let homeViewController = HomeViewController(contentView: homeView)
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    func navigateToListArtistsViewController() -> UINavigationController {
        let lastArtistSearched = userDefaults.string(forKey: "lastArtistSearched") ?? ""
        let listArtistsView = ListArtistsView()
        let listArtistsViewController = ListArtistsViewController(contentView: listArtistsView)
        listArtistsView.searchArtistTextField.text = lastArtistSearched
        listArtistsViewController.lastArtistSearched = lastArtistSearched
        let navigationController = UINavigationController(rootViewController: listArtistsViewController)
        return navigationController
    }
}
