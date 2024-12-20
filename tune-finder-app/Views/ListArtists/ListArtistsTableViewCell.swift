//
//  ListArtistsTableViewCell.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 17/12/24.
//

import UIKit

class ListArtistsTableViewCell: UITableViewCell {
    static let identifier: String = "ListArtistsTableViewCell"
    
    private lazy var imageArtist: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageTestTableView")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Michael Jackson"
        label.textColor = .whitePrimaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var descriptionAlbums: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adult standards, canadian pop, jazz pop..."
        label.textColor = .graySecundaryColor
        label.font = .secondaryFont
        return label
    }()
    
    private lazy var textArtistsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleArtist, descriptionAlbums]
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
        addSubview(artistsStackView)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            artistsStackView.topAnchor.constraint(equalTo: topAnchor),
            artistsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            artistsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configureCell(artist: Item) {
        imageArtist.image = UIImage(named: "imageTestTableView")
        titleArtist.text = artist.name
        descriptionAlbums.text = artist.genres.joined(separator: ", ")
    }
}
