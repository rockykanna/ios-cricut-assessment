//
//  CricutGridView.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/17/25.
//

import SwiftUI
//Reusuable Grid View to display shapes
struct CricutGridView: View {
    let drawItems: [PaletteItem]
    let columns: [GridItem]
   
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(drawItems, id: \.self) { asset in
                        shapeView(asset)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.cyan)
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder func shapeView(_ item: PaletteItem) -> some View {
        switch item.drawPath {
        case .circle:
            Circle()
        case .triangle:
            Triangle()
        case .square:
            Rectangle()
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    CricutGridView(
        drawItems: [],
        columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    )
}
