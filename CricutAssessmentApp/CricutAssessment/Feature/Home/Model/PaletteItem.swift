//
//  PaletteItem.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/16/25.
//

import Foundation

struct PaletteResponse: Codable {
    let buttons: [PaletteItem]
}

struct PaletteItem: Identifiable, Codable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let drawPath: PaletteAsset

    enum CodingKeys: String, CodingKey {
            case name
            case drawPath = "draw_path"
    }
}

enum PaletteAsset: String, Codable, CaseIterable, Equatable, Identifiable {
    case circle
    case triangle
    case square
    
    var id: String { self.rawValue }
}
