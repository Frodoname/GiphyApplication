//
//  TrendRequest.swift
//  GiphyApp
//
//  Created by Fed on 26.03.2023.
//

import Foundation

final class TrendRequest: NetworkRequestProtocol {
    typealias ResponseType = GIFModel

    let endpoint: Endpoint
    let method: HTTPMethod = .get

    init(offset: Int) {
        endpoint = .trends(with: offset)
    }
}
