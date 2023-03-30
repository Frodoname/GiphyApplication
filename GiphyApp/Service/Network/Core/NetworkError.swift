//
//  NetworkError.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case networkError
    case invalidResponse
    case noData
    case decodingError
    case serverError(statusCode: Int)
}
