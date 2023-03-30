//
//  UIView+Extension.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//

import UIKit

extension UIView {
    
    @discardableResult
    func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
