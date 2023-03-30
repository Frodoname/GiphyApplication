//
//  ErrorView.swift
//  GiphyApp
//
//  Created by Fed on 28.03.2023.
//

import UIKit

final class ErrorView: UIView {
    
    typealias CallBackType = () -> Void
    
    // MARK: - Constants
    
    var callBack: CallBackType?
    var errorType: ErrorType
    
    private enum Button {
        static let height: CGFloat = 40
        static let width: CGFloat = 146
        static let cornerRadius: CGFloat = 20
    }
    
    // MARK: - Init
    
    init(_ errorType: ErrorType) {
        self.errorType = errorType
        super.init(frame: .zero)
        configureLayout()
        configureViewState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Button.cornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Text.reload, for: .normal)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, button])
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        callBack?()
    }
    
    // MARK: - Private methods
    
    private func configureViewState() {
        switch errorType {
        case .dataError:
            imageView.image = Media.network.image
            button.isHidden = false
        case .noResults:
            imageView.image = Media.noResults.image
            button.isHidden = true
        }
    }
    
    private func configureLayout() {
        [vStack].forEach {
            addSubview($0)
            $0.prepareForAutoLayout()
        }
        
        [button].forEach {
            $0.prepareForAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.heightAnchor.constraint(equalToConstant: Button.height),
            button.widthAnchor.constraint(equalToConstant: Button.width)
        ])
    }
}
