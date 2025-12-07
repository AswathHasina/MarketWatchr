//
//  SymbolDetailScreen.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import SwiftUI

struct SymbolDetailScreen: View {
    let stock: Stock
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Current Price")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(String(format: "$%.2f", stock.price))
                            .font(.system(size: 48, weight: .bold))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                
                // Company Info
                VStack(alignment: .leading, spacing: 15) {
                    Text("About")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(stock.companyName)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(stock.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SymbolDetailScreen(stock: Stock(symbol: "GYT", price: 23.123, previousPrice: 12.56, companyName: "TEST", description: "testing") )
}
