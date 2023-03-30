//
//  ImagesDto.swift
//  GiphyApp
//
//  Created by Fed on 30.03.2023.
//

import Foundation

struct ImagesDto: Decodable {
    let original: ImageInfoDto
    let downsized: ImageInfoDto
}
