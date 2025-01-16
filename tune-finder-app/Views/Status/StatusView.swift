//
//  StatusView.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class StatusView: UIView {
    private lazy var statusImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .whitePrimaryColor
        label.font = .primaryFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tentar novamente", for: .normal)
        button.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    var retryActionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(status: Status) {
        switch status {
        case .loading:
            statusImageView.image = UIImage(systemName: "hourglass")
            statusLabel.text = status.message
            statusButton.isHidden = true
        case .success:
            isHidden = true
        case .error:
            statusImageView.image = UIImage(systemName: "xmark.octagon.fill")
            statusLabel.text = status.message
            statusButton.isHidden = false
            statusButton.setTitle("Tentar novamente", for: .normal)
        case .empty:
            statusImageView.image = UIImage(systemName: "tray.fill")
            statusLabel.text = status.message
            statusButton.isHidden = false
            statusButton.setTitle("Voltar", for: .normal)
        }
    }
    
    @objc private func retryAction() {
        if self.statusButton.titleLabel?.text == "Tentar novamente" {
            self.retryActionHandler?()
        } else if self.statusButton.titleLabel?.text == "Voltar" {
            if let navigationController = self.findViewController()?.navigationController {
                if let homeViewController = navigationController.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
                    //homeViewController.returnToPreviousView()
                } else if let listArtistsViewController = navigationController.viewControllers.first(where: { $0 is ListArtistsViewController}) as? ListArtistsViewController {
                    //listArtistsViewController.returnToPreviousView()
                }
            }
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(statusImageView)
        addSubview(statusLabel)
        addSubview(statusButton)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            statusImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            statusImageView.widthAnchor.constraint(equalToConstant: 60),
            statusImageView.heightAnchor.constraint(equalToConstant: 60),
            
            statusLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            statusButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
