//
//  FeedView.swift
//  MarketWatchr
//
//  Created by Aswath on 25/11/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = StockFeedViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    // Connection Status
                    HStack(spacing: 6) {
                        Circle()
                            .fill(viewModel.isConnected ? Color.green : Color.red)
                            .frame(width: 12, height: 12)
                        Text(viewModel.isConnected ? "Connected" : "Disconnected")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Toggle Button
                    Button(action: {
                        viewModel.toggleFeed()
                    }) {
                        Text(viewModel.isFeedActive ? "Stop Feed" : "Start Feed")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(viewModel.isFeedActive ? Color.red : Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 2, y: 2)
                
                // Stock List
                List(viewModel.stocks) { stock in
                    NavigationLink(destination: SymbolDetailsView()) {
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
    FeedView()
}
