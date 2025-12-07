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
            Text(stock.symbol)
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            
            Text(stock.companyName)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Spacer()
            
            Text(String(format: "$%.2f", stock.price))
                .font(.title3)
                .fontWeight(.semibold)
            
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

#Preview {
    StockRow(stock: Stock(symbol: "test", price: 15.67, previousPrice: 123.123, companyName: "TEST", description: "tesing sdesad"))
    StockRow(stock: Stock(symbol: "test", price: 15.67, previousPrice: 1.1, companyName: "TEST", description: "tesing sdesad"))
}
