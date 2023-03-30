//
//  SearchRequest.swift
//  GiphyApp
//
//  Created by Fed on 26.03.2023.
//

import Foundation

final class SearchRequest: NetworkRequestProtocol {
    typealias ResponseType = GIFModel

    let endpoint: Endpoint
    let method: HTTPMethod = .get

    init(_ query: String, offset: Int) {
        endpoint = .search(query, offset: offset)
    }
}
