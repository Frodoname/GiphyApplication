//
//  DiverderView.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import UIKit

final class DiverderView: UIView {
    
    // MARK: - Constants
    
    private let height: CGFloat = 1
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = Media.Color.supportSeparator.color
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
