//
//  DetailView.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/17/25.
//

import SwiftUI

struct DetailView: View {
    private let columns: [GridItem] = Array(
            repeating: GridItem(.flexible(), spacing: 16),
            count: 3
        )
    @State var selectedAsset: PaletteAsset = .circle
    // Injecting HomeViewModel as Environment Object to reuse the same ViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    // Filtering the drawItems based on selected asset
    var displayItems : [PaletteItem] { homeViewModel.drawItems.filter { $0.drawPath == selectedAsset }
    }
    
    var body: some View {
        VStack {
            // Reusing CricutGridView to display shapes based on selected asset
            CricutGridView(drawItems: displayItems, columns: columns)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
            
                    Button("Delete All", action: {
                        homeViewModel.removeAll(paletteAsset: selectedAsset)
                        })
                        .frame(maxWidth: .infinity)
                    Button("Add", action: {
                        homeViewModel.addItem(paletteItem: PaletteItem(name: selectedAsset.rawValue.capitalized, drawPath: selectedAsset))
                        })
                        .frame(maxWidth: .infinity)
                    Button("Remove", action: {
                        homeViewModel.removeLast(paletteAsset: selectedAsset)
                        })
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
}
    
    


#Preview {
    DetailView(selectedAsset: .circle)
        .environmentObject(HomeViewModel())
}
