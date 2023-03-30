//
//  URLConstructor.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

private enum API {
    static let key = "Zz7XnA0RZzJJetQAQv1e2c7ErivA9F5u"

    enum ResultLimit {
        static let trends = "25"
        static let search = "15"
    }
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/" + path
        components.queryItems = queryItems
        return components.url
    }

    static func trends(with offset: Int) -> Self {
        Endpoint(path: "v1/gifs/trending",
                       queryItems: [
                        URLQueryItem(name: "api_key", value: API.key),
                        URLQueryItem(name: "limit", value: API.ResultLimit.trends),
                        URLQueryItem(name: "offset", value: String(offset))
                       ])
    }

    static func search(_ request: String, offset: Int) -> Self {
        Endpoint(path: "v1/gifs/search",
                       queryItems: [
                        URLQueryItem(name: "api_key", value: API.key),
                        URLQueryItem(name: "limit", value: API.ResultLimit.search),
                        URLQueryItem(name: "offset", value: String(offset)),
                        URLQueryItem(name: "q", value: request)
                       ])
    }
}
