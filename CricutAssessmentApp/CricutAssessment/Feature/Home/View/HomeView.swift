//
//  HomeView.swift
//  CricutAssessment
//
//  Created by KANNAN SHANMUGAM on 11/15/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 3
    )
    @State private var selectedAsset: PaletteAsset? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                CricutGridView(drawItems: homeViewModel.drawItems, columns: columns)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All", action: {
                        homeViewModel.removeAll()
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit Circle") {
                        selectedAsset = .circle
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        ForEach (homeViewModel.paletteItems) { item in
                            Button(item.name, action: {
                                homeViewModel.addItem(paletteItem: item)
                            })
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationDestination(item: $selectedAsset) { asset in
                //Passing the selected asset to Detail View and also injecting the HomeViewModel as Environment Object. Reuse the ViewModel to maintain single source of truth
                DetailView(selectedAsset: asset)
                    .environmentObject(homeViewModel)
            }
            .padding()
            .onAppear {
                Task {
                    await homeViewModel.fetchData()
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
