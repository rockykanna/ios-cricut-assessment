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

        AnyView(item.drawPath.style.apply(item.drawPath.shape.shapeView))
    }

    func style<T: Shape>(_ shape: T, style: String) -> some View {
        switch style {
        case "dotted":
            return AnyView(shape.stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [5], dashPhase: 0)))
        case "stroked":
            return AnyView(shape.stroke(lineWidth: 2))
        default:
            return AnyView(shape)
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
