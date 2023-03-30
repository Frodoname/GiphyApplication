//
//  GIFDto.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

struct GIFDto: Decodable {
    let id = UUID()
    let userName: String
    let source: String
    let title: String
    let importDateTime: String
    let images: ImagesDto
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case source
        case title
        case importDateTime = "import_datetime"
        case images
    }
}
