//
//  NetworkServiceProtocol: A.swift
//  GiphyApp
//
//  Created by Fed on 26.03.2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol: AnyObject {
    var decoder: JSONDecoder { get }
    var urlSession: URLSession { get }
    var dtoService: DtoService { get }
    
    func get<T: NetworkRequestProtocol>(request: T) -> AnyPublisher<GIFModel, NetworkError>
}
