//
//  DetailView.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import UIKit
import Kingfisher

final class DetailView: UIView {
    
    // MARK: - Constants
    
    let gif: GIF
    
    private let dateFormatter = DateFormatterFactory.dateFormatter
    
    private let cornerRadius: CGFloat = 16
    
    private enum Font {
        static let primary: CGFloat = 17
        static let secondary: CGFloat = 15
    }
    
    private enum GifSize {
       static let lPadding: CGFloat = 20
       static let tPadding: CGFloat = -20
   }

    private enum LabelSize {
       static let topPadding: CGFloat = 20
       static let lPadding: CGFloat = 32
       static let tPadding: CGFloat = -32
   }

    private enum StackSize {
       static let topPadding: CGFloat = 12
       static let lPadding: CGFloat = 20
       static let tPadding: CGFloat = -20
   }
    
    // MARK: - Computed Properties
    
    private var userName: String {
        gif.userName.isEmpty ? Text.noNickName : gif.userName
    }
    
    private var uploadTime: String {
        let inputDate = dateFormatter.date(from: gif.importDateTime) ?? Date()
        dateFormatter.dateFormat = "d MMMM, yyyy"
        let outputDate = dateFormatter.string(from: inputDate)
        return outputDate
    }
    
    // MARK: - Init
    
    init(gif: GIF) {
        self.gif = gif
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private lazy var gifView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = cornerRadius
        image.clipsToBounds = true
        guard let url = URL(string: gif.originalImage) else {
            return image
        }
        image.kf.setImage(with: url)
        return image
    }()
    
    private lazy var detailLabel: UILabel = {
       let label = UILabel()
        label.textColor = Media.Color.labelTertiary.color
        label.text = Text.details
        label.font = UIFont.systemFont(ofSize: Font.secondary)
        return label
    }()
    
    private lazy var userLabel: LabelView = {
        let label = UILabel()
        label.textColor = Media.Color.labelPrimary.color
        label.text = Text.uploadedBy + userName
        let labelView = LabelView(label: label)
        label.font = UIFont.systemFont(ofSize: Font.primary)
        return labelView
    }()
    
    private lazy var dateLabel: LabelView = {
        let label = UILabel()
        label.textColor = Media.Color.labelPrimary.color
        label.text = Text.uploadTime + uploadTime
        let labelView = LabelView(label: label)
        return labelView
    }()
    
    private lazy var vStack: GifDetailStack = {
        let stack = GifDetailStack(labels: [userLabel, dateLabel])
        return stack
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    // MARK: - Private Methods
    
    private func configureLayout() {
        [scrollView].forEach {
            addSubview($0)
            $0.prepareForAutoLayout()
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
            $0.prepareForAutoLayout()
        }
        
        [gifView, detailLabel, vStack].forEach {
            contentView.addSubview($0)
            $0.prepareForAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            gifView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            gifView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GifSize.lPadding),
            gifView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: GifSize.tPadding),
            
            detailLabel.topAnchor.constraint(equalTo: gifView.bottomAnchor, constant: LabelSize.topPadding),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LabelSize.lPadding),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LabelSize.tPadding),
            
            vStack.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: StackSize.topPadding),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StackSize.lPadding),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: StackSize.tPadding),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
