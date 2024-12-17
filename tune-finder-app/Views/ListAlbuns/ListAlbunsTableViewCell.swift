//
//  ListAlbunsTableViewCell.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbunsTableViewCell: UITableViewCell {
    static let identifier: String = "ListAlbunsTableViewCell"
    
    private lazy var imageAlbum: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageTestTableView2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thriller 40"
        label.textColor = .whitePrimaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var descriptionAlbuns: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/11/2022 -  9 Músicas"
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var textAlbumStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleAlbum, descriptionAlbuns]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var albunsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [imageAlbum, textAlbumStackView]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(albunsStackView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            albunsStackView.topAnchor.constraint(equalTo: topAnchor),
            albunsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            albunsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albunsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
