//
//  PaletteItem.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/16/25.
//

import Foundation
import SwiftUICore

struct PaletteResponse: Codable {
    let buttons: [PaletteItem]
}

struct PaletteItem: Identifiable, Codable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let drawPath: ShapeType

    enum CodingKeys: String, CodingKey {
            case name
            case drawPath = "draw_path"
    }
}

struct ShapeType: Identifiable, Equatable, Hashable, Codable {
    let id = UUID()
    let shape: PaletteAsset
    let style: DrawShapeStyle
}

enum DrawShapeStyle: String, Codable, Equatable {
    case filled
    case stroked
    case dotted
    
    func apply<T: Shape>(_ shape: T) -> some View {
        switch self {
        case .stroked:
            return AnyView(shape.stroke(lineWidth: 2))
        case .dotted:
            return AnyView( shape.stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [5], dashPhase: 0)))
        case .filled:
            return AnyView(shape)
        }
    }
}

enum PaletteAsset: String, Codable, CaseIterable, Equatable, Identifiable {
    case circle
    case triangle
    case square
    var id: String { self.rawValue }
    
    var shapeView: any Shape {
        switch self {
        case .circle:
            return Circle()
        case .triangle:
            return Triangle()
        case .square:
            return Rectangle()
        }
    }
}



//struct PaletteAsset: String, Codable, CaseIterable, Equatable, Identifiable, PaletteAssetProtocol {
//
//    var id: String { self.rawValue }
//        
//}




