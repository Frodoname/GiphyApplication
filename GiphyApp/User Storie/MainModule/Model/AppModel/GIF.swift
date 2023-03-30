//
//  GIF.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

final class GIF {
    let id: UUID
    let userName: String
    let title: String
    let importDateTime: String
    let downSizedImage: String
    let originalImage: String
    
    init(id: UUID = UUID(),
         userName: String,
         title: String,
         importDateTime: String,
         downSizedImage: String,
         originalImage: String) {
        self.id = id
        self.userName = userName
        self.title = title
        self.importDateTime = importDateTime
        self.downSizedImage = downSizedImage
        self.originalImage = originalImage
    }
}

extension GIF: Hashable, ObservableObject {
    
    static func == (lhs: GIF, rhs: GIF) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
