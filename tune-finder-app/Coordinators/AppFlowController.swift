//
//  AppFlowController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class AppFlowController {
    private var navigationController: UINavigationController?
    
    //init() {
    //}
    
    func startFlow() -> UINavigationController? {
        let splashScreenView = SplashScreenView()
        let splashScreenViewController = SplashScreenViewController(contentView: splashScreenView, delegate: self)
        self.navigationController = UINavigationController(rootViewController: splashScreenViewController)
        return navigationController
    }
}

extension AppFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let homeView = HomeView()
        let homeViewController = HomeViewController(contentView: homeView)
        navigationController?.pushViewController(homeViewController, animated: false)
    }
}
