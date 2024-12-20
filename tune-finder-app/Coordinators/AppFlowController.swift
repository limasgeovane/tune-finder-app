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
        //let splashScreenView = StateView()
        //let splashScreenViewController = StateViewController(contentView: splashScreenView)//, delegate: self)
        self.navigationController = UINavigationController(rootViewController: splashScreenViewController)
        return navigationController
    }
    
    func navigateToHomeViewController() {
        let homeView = HomeView()
        let service = Service()
        let homeViewController = HomeViewController(contentView: homeView, service: service)
        navigationController?.pushViewController(homeViewController, animated: false)
    }
}
