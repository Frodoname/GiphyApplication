//
//  PaginationDto.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

struct PaginationDto: Decodable {
    let totalCount: Int
    let count: Int
    let offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}
