//
//  ViewModelState.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import Foundation

enum ViewModelState: Equatable {
    case initialLoading
    case loading
    case noResult
    case successfulLoaded
    case error(NetworkError)
}
