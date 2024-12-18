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
        //let splashScreenView = StateView()
        //let splashScreenViewController = StateViewController(contentView: splashScreenView)//, delegate: self)
        self.navigationController = UINavigationController(rootViewController: splashScreenViewController)
        return navigationController
    }
}

extension AppFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let homeView = HomeView()
        let service = Service()
        let homeViewController = HomeViewController(contentView: homeView, service: service)
        navigationController?.pushViewController(homeViewController, animated: false)
    }
}

extension HomeView {
    func navigateToListArtistsViewController() {
        let listArtistsViewController = ListArtistsViewController(contentView: ListArtistsView())
        
        if let viewController = parentViewController() {
            viewController.navigationController?.pushViewController(listArtistsViewController, animated: true)
        }
    }
    
    private func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
