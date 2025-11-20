//
//  APIService.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/16/25.
//

import Foundation

protocol PaletteServiceProtocol {
    func fetchData() async throws -> Result<PaletteResponse, APIError>
}

class PaletteService: PaletteServiceProtocol {
    
    private let network: NetworkingProtocol
    
    init(network: NetworkingProtocol = NetworkManager.shared) {
            self.network = network
    }
    
    let url = URL(string: "https://staticcontent.cricut.com/static/test/shapes_001.json")!
    
    func fetchData() async throws -> Result<PaletteResponse, APIError> {
    
        let (data, response) = try await network.request(url)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return .failure(.dataError)
        }
        do {
            let paletteResponse = try JSONDecoder().decode(PaletteResponse.self, from: data)
            print("Fetched \(paletteResponse.buttons.count) items")
            return .success(paletteResponse)
        } catch {
            return .failure(.decodingError(error))
        }
    }
}
