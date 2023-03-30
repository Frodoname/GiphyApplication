//
//  LabelView.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import UIKit

final class LabelView: UIView {
    
    // MARK: - Constants
    
    let label: UILabel
    
    private let padding: CGFloat = 16
    private let labelHeight: CGFloat = 56
    
    // MARK: - Init
    
    init(label: UILabel) {
        self.label = label
        super.init(frame: .zero)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        backgroundColor = Media.Color.backSecondary.color
        prepareForAutoLayout()
        heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
    }
    
    private func configureLayout() {
        [label].forEach {
            addSubview($0)
            $0.prepareForAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
