//
//  NetworkManager.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/17/25.
//

import Foundation

enum APIError: Error {
    case networkError(Error)
    case dataError
    case decodingError(Error)
}

protocol NetworkingProtocol {
    func request(_ url: URL) async throws -> (Data, URLResponse)
}

final class NetworkManager: NetworkingProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 12
        config.timeoutIntervalForResource = 15
        return URLSession(configuration: config)
    }()
    
    func request(_ url: URL) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await session.data(from: url)
            return (data, response)
        } catch {
            throw APIError.networkError(error)
        }
    }
}
