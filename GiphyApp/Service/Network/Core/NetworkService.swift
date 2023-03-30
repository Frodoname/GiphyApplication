//
//  NetworkingService.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    
    let decoder: JSONDecoder
    let urlSession: URLSession
    let dtoService: DtoService
    
    init(decoder: JSONDecoder = .init(), urlSession: URLSession = .shared, dtoService: DtoService = DtoService()) {
        self.decoder = decoder
        self.urlSession = urlSession
        self.dtoService = dtoService
    }
    
    func get<T: NetworkRequestProtocol>(request: T) -> AnyPublisher<GIFModel, NetworkError> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<GIFModel, NetworkError> { [weak self] promise in
            
            guard let self else { return }
            
            guard let url = request.endpoint.url else {
                promise(.failure(NetworkError.invalidURL))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            
            dataTask = self.urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    promise(.failure(.networkError))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    promise(.failure(.invalidResponse))
                    return
                }

                guard let data else {
                    promise(.failure(.noData))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    guard let decodedData = try? self.decoder.decode(GiphyModelDto.self, from: data) else {
                        promise(.failure(.decodingError))
                        return
                    }
                    let tranformedData = self.dtoService.transform(from: decodedData)
                    promise(.success(tranformedData))
                default:
                    promise(.failure(.serverError(statusCode: httpResponse.statusCode)))
                }
            })
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
