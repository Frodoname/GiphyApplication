//
//  MainViewModel.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import Foundation
import Combine

final class MainViewModel {
    
    @Published private(set) var gifs: [GIF] = []
    @Published private(set) var state: ViewModelState = .initialLoading
    
    var currentSearchQuery: String?
    var currentOffset = 0
    var canLoadMoreItems = true
    var isFirstPageLoading = true
    private let networkService: NetworkServiceProtocol
    private let audioService: AudioService
    private var bindingSet = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService(), audioService: AudioService = AudioService()) {
        self.networkService = networkService
        self.audioService = audioService
    }
    
    func playSound() {
        audioService.playAudioLoop()
    }
    
    func getData() {
        guard state != .loading && canLoadMoreItems else { return }
        if let searchQuery = currentSearchQuery, !searchQuery.isEmpty {
            let request = SearchRequest(searchQuery, offset: currentOffset)
            fetch(with: request)
        } else {
            currentSearchQuery = nil
            let request = TrendRequest(offset: currentOffset)
            fetch(with: request)
        }
    }
}

private
extension MainViewModel {
    
    func fetch<T: NetworkRequestProtocol>(with request: T) {
        
        if isFirstPageLoading {
            state = .initialLoading
        } else {
            state = .loading
        }
        
        isFirstPageLoading = false
        
        let getDataCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            guard let self else { return }
            
            switch completion {
            case .failure(let error):
                self.state = .error(error)
            case .finished:
                if self.gifs.isEmpty {
                    self.state = .noResult
                } else {
                    self.state = .successfulLoaded
                }
            }
        }
        
        let getDataHandler: (GIFModel) -> Void = { [weak self] data in
            
            guard let self else { return }
            
            if self.currentOffset == 0 {
                self.gifs.removeAll()
            }
            
            if data.totalCount == self.currentOffset {
                self.canLoadMoreItems = false
            }
            
            self.gifs.append(contentsOf: data.gif)
            self.currentOffset += data.gif.count
        }
        
        networkService
            .get(request: request)
            .sink(receiveCompletion: getDataCompletionHandler, receiveValue: getDataHandler)
            .store(in: &bindingSet)
    }
}
