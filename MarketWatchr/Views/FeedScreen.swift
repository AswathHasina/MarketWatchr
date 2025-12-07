//
//  ContentView.swift
//  MarketWatchr
//
//  Created by Aswath on 25/11/25.
//

import SwiftUI

struct FeedScreen: View {
    @StateObject private var viewModel = StockFeedViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
                TopBar(isConnected: viewModel.isConnected, isFeedActive: $viewModel.isFeedActive, onToggle: {
                    print("🦋")
                    viewModel.toggleFeed()
                })
                
                // symbol List
                List(viewModel.stocks) { stock in
                    NavigationLink(destination: SymbolDetailScreen(stock: stock)) {
                        StockRow(stock: stock)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Stock Feed")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    FeedScreen()
}
