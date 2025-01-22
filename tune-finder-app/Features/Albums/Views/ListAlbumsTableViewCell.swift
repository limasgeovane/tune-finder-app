//
//  ListAlbumsTableViewCell.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListAlbumsTableViewCell: UITableViewCell {
    static let identifier: String = "ListAlbumsTableViewCell"
    
    private let imageAlbum: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageError")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thriller 40"
        label.textColor = .whitePrimaryColor
        label.font = .secondaryFont
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/11/2022 - 9 Músicas"
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private let totalTracksAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9 Músicas"
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private let separatorToLabel: UILabel = {
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
    
    func configureCell(album: Album) {
        if let imageURLString = album.image, let imageURL = URL(string: imageURLString) {
            imageAlbum.kf.setImage(with: imageURL)
        } else {
            imageAlbum.image = UIImage(named: "imageError")
        }
        titleAlbum.text = album.name
        releaseDateAlbum.text = album.releaseDate.toBrazilianDateFormat()
        if album.totalTracks == 1 {
            totalTracksAlbum.text = "\(album.totalTracks) Música"
        } else {
            totalTracksAlbum.text = "\(album.totalTracks) Músicas"
        }
    }
}
