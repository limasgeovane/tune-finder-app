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
        imageView.image = UIImage(named: "imageError")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thriller 40"
        label.textColor = .whitePrimaryColor
        label.font = .secondaryFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var releaseDateAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/11/2022 - 9 Músicas"
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
        return label
    }()
    
    private lazy var releaseDateAndTrackStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [releaseDateAlbum, separatorToLabel, totalTracksAlbum]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = -1
        return stackView
    }()
    
    private lazy var descriptionAlbumStackView: UIStackView = {
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
            arrangedSubviews: [imageAlbum, descriptionAlbumStackView]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
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
            imageAlbum.widthAnchor.constraint(equalToConstant: 114),
            
            albumsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            albumsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            albumsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            albumsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configureCell(albums: Items) {
        if let imageURLString = albums.images.first?.url, let imageURL = URL(string: imageURLString) {
            imageAlbum.kf.setImage(with: imageURL)
        } else {
            imageAlbum.image = UIImage(named: "imageError")
        }
        titleAlbum.text = albums.name
        releaseDateAlbum.text = albums.release_date.toBrazilianDateFormat()
        if albums.total_tracks == 1 {
            totalTracksAlbum.text = "\(albums.total_tracks) Música"
        } else {
            totalTracksAlbum.text = "\(albums.total_tracks) Músicas"
        }
    }
}
