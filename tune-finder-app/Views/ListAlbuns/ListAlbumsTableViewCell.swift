//
//  ListAlbumsTableViewCell.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbumsTableViewCell: UITableViewCell {
    static let identifier: String = "ListAlbumsTableViewCell"
    
    private lazy var imageAlbum: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageDefaultTableView2")
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
    
    private lazy var releaseDateAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/11/2022 -  9 Músicas"
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var totalTracksAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9 Músicas"
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var separatorToLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " - "
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        label.textAlignment = .center
        return label
    }()
    
    private lazy var releaseDateAndTrackStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [releaseDateAlbum, separatorToLabel, totalTracksAlbum]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var textAlbumStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleAlbum, releaseDateAndTrackStackView]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var albumsStackView: UIStackView = {
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
        addSubview(albumsStackView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            albumsStackView.topAnchor.constraint(equalTo: topAnchor),
            albumsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            albumsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configureCell(albums: Items) {
        if let imageURLString = albums.images.first?.url, let imageURL = URL(string: imageURLString) {
            imageAlbum.kf.setImage(with: imageURL)
        } else {
            imageAlbum.image = UIImage(named: "imageDefaultTableView2")
        }
        titleAlbum.text = albums.name
        releaseDateAlbum.text = albums.release_date.toBrazilianDateFormat()
        totalTracksAlbum.text = "\(albums.total_tracks) Músicas"
    }
}
