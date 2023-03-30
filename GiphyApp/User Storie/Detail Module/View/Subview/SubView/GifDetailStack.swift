//
//  GifDetailStack.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import UIKit

final class GifDetailStack: UIStackView {
    
    let labels: [UIView]
    
    private let conerRadius: CGFloat = 16
    
    // MARK: - Init
    
    init(labels: [UIView]) {
        self.labels = labels
        super.init(frame: .zero)
        configureView()
        configureLabels()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        axis = .vertical
        layer.cornerRadius = conerRadius
        clipsToBounds = true
        backgroundColor = Media.Color.backSecondary.color
    }
    
    private func configureLabels() {
        for index in labels.indices {
            addArrangedSubview(labels[index])
            guard index != labels.count - 1 else { return }
            addArrangedSubview(DiverderView())
        }
    }
}
