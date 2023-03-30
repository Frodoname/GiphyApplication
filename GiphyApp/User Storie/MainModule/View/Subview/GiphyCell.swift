//
//  GiphyCell.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//

import UIKit
import Kingfisher

final class GiphyCell: UICollectionViewCell {
    
    // MARK: - Public Methods

    func configure(with model: GIF) {
        guard let url = URL(string: model.downSizedImage) else { return }
        giphyView.kf.indicatorType = .activity
        giphyView.kf.setImage(with: url)
    }

    // MARK: - Local Constants

    private let cornerRadius: CGFloat = 16

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        cellSetup()
        layoutSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private lazy var giphyView: AnimatedImageView = {
        let imageView = AnimatedImageView()
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Private methods

    private func cellSetup() {
        backgroundColor = Media.Color.backSecondary.color
        layer.cornerRadius = cornerRadius
    }

    private func layoutSetup() {
        [giphyView].forEach {
            contentView.addSubview($0)
            $0.prepareForAutoLayout()
        }

        NSLayoutConstraint.activate([
            giphyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            giphyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            giphyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            giphyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Extenstion

extension GiphyCell: ReusableCellProtocol { }
