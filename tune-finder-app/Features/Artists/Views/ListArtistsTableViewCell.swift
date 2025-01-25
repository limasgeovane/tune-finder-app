//
//  ListArtistsTableViewCell.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit
import Kingfisher

class ListArtistsTableViewCell: UITableViewCell {
    static let identifier: String = "ListArtistsTableViewCell"
    
    private let imageArtist: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageError")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .whitePrimaryColor
        label.font = .secondaryFont
        label.numberOfLines = 0
        return label
    }()
    
    private let genresArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var textArtistsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [nameArtist, genresArtist]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var artistsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [imageArtist, textArtistsStackView]
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
        addSubview(artistsStackView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            imageArtist.widthAnchor.constraint(equalToConstant: 68),
            
            artistsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            artistsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            artistsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            artistsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configureCell(artist: Artist) {
        if let imageURLString = artist.image, let imageURL = URL(string: imageURLString) {
            imageArtist.kf.setImage(with: imageURL)
        } else {
            imageArtist.image = UIImage(named: "imageError")
        }
        nameArtist.text = artist.name
        genresArtist.text = artist.genres
    }
}
