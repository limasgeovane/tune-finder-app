//
//  SplashScreenViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

protocol SplashScreenDelegate: AnyObject {
    func splashScreenDidFinishAnimation()
}

class SplashScreenViewController: UIViewController {
    private let contentView: SplashScreenView
    private var delegate: SplashScreenDelegate
    
    init(contentView: SplashScreenView, delegate: SplashScreenDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        decideFlow()
    }
    
    private func decideFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.delegate.splashScreenDidFinishAnimation()
        }
    }
}
