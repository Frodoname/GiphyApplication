//
//  GiphyModelDto.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

struct GiphyModelDto: Decodable {
    let data: [GIFDto]
    let pagination: PaginationDto?
}
