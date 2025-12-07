//
//  StockRow.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import SwiftUI

struct StockRow: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            // Symbol
            Text(stock.symbol)
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            // Price
            Text(String(format: "$%.2f", stock.price))
                .font(.title3)
                .fontWeight(.semibold)
            
            // Change Indicator
            HStack(spacing: 4) {
                Image(systemName: stock.isUp ? "arrow.up" : "arrow.down")
                    .font(.caption)
                Text(String(format: "%.2f", abs(stock.priceChange)))
                    .font(.caption)
            }
            .foregroundColor(stock.isUp ? .green : .red)
            .frame(width: 70, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }
}
