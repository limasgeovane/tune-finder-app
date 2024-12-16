//
//  SplashScreenViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let contentView: SplashScreenView
    private weak var delegate: SplashFlowDelegate?
    
    init(contentView: SplashScreenView, delegate: SplashFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        decideFlow()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
    
    private func decideFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.delegate?.decideNavigationFlow()
        }
    }
}
