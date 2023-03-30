//
//  NetworkingRequestProtocol.swift
//  GiphyApp
//
//  Created by Fed on 26.03.2023.
//

import Foundation

protocol NetworkRequestProtocol: AnyObject {

    var endpoint: Endpoint { get }
    var method: HTTPMethod { get }
}
