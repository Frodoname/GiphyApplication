//
//  ReusableCellProtocol.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//

import Foundation

protocol ReusableCellProtocol {
    static var identifier: String { get }
    func configure(with model: GIF)
}

extension ReusableCellProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
