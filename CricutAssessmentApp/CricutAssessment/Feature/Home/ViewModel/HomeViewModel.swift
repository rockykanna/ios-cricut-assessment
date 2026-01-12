//
//  HomeViewModel.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/15/25.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var paletteItems: [PaletteItem] = []
    @Published var drawItems: [PaletteItem] = []
    var service: PaletteServiceProtocol
    init(service: PaletteServiceProtocol = PaletteService()) {
        self.service = service
    }
    
    // Palette Data Fetching Method from Service - Async/Await
    func fetchData() async {
        do {
            let result = try await service.fetchData()
            switch result {
            case .success(let response):
                self.paletteItems = response.buttons
                print("Data fetched successfully: \(response)")
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    //Shape Manipulation Methods

    func removeAll() {
        drawItems.removeAll()
    }
    
    func removeLast(paletteAsset:PaletteAsset) {
        if let index = drawItems.lastIndex(where: { $0.drawPath.shape == paletteAsset }) {
            drawItems.remove(at: index)
        }
    }
    
    func removeAll(paletteAsset:PaletteAsset) {
        drawItems.removeAll(where: { $0.drawPath.shape == paletteAsset })
    }
    
    func addItem(paletteItem:PaletteItem) {
        let paletteItem = PaletteItem(name: paletteItem.name, drawPath: paletteItem.drawPath)
        drawItems.append(paletteItem)
    }
    
}
