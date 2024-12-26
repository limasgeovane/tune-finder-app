//
//  StatusViewController.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class StatusViewController: UIViewController {
    private let contentView: StatusView
    
    init(contentView: StatusView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        setupConstraintsViewController(contentView: contentView)
    }
    
    func setStatus(status: ServiceStatus) {
        contentView.configure(status: status)
    }
}
