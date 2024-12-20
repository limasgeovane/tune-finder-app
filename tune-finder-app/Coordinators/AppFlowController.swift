//
//  AppFlowController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class AppFlowController: SplashFlowDelegate{
    private var navigationController: UINavigationController?

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
}
