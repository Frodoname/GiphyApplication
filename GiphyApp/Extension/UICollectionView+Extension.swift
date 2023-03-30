//
//  UICollectionView+Extension.swift
//  GiphyApp
//
//  Created by Fed on 27.03.2023.
//

import UIKit

extension UICollectionView {

    func setAnimation() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    
    func restore() {
        backgroundView = nil
    }
    
    func showError(_ errorType: ErrorType, completion: (() -> Void)? = nil) {
        let errorView = ErrorView(errorType)
        backgroundView = errorView
        errorView.callBack = completion
    }
}
