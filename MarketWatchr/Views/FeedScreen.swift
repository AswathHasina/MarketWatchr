//
//  ContentView.swift
//  MarketWatchr
//
//  Created by Aswath on 25/11/25.
//

import SwiftUI

struct FeedScreen: View {
    @EnvironmentObject var viewModel: StockFeedViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
                TopBar(
                    isConnected: viewModel.isConnected,
                    isFeedActive: viewModel.isFeedActive,
                    onToggle: {
                        viewModel.toggleFeed()
                    }
                )
                
                // symbol List
                List(viewModel.stocks) { stock in
                    NavigationLink(value: stock.symbol) {
                        StockRow(stock: stock, isFlashing: viewModel.isFlashing(stock.symbol))
                    }
                }
                .listStyle(PlainListStyle())
                .navigationDestination(for: String.self) { symbol in
                    SymbolDetailScreen(symbol: symbol)
                }
            }
            .navigationTitle("Stock Feed")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    FeedScreen()
        .environmentObject(StockFeedViewModel())
}
