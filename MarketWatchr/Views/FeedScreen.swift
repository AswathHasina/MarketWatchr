//
//  ContentView.swift
//  MarketWatchr
//
//  Created by Aswath on 25/11/25.
//

import SwiftUI

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let companyName: String
}

// feed list
let stocks: [Stock] = [
    Stock(symbol: "AAPL", price: 178.25, companyName: "Apple Inc."),
    Stock(symbol: "GOOGL", price: 142.50, companyName: "Alphabet Inc."),
    Stock(symbol: "MSFT", price: 378.91, companyName: "Microsoft Corporation"),
    Stock(symbol: "AMZN", price: 153.38, companyName: "Amazon.com Inc."),
    Stock(symbol: "TSLA", price: 242.84, companyName: "Tesla Inc."),
    Stock(symbol: "META", price: 352.79, companyName: "Meta Platforms Inc."),
    Stock(symbol: "NVDA", price: 495.22, companyName: "NVIDIA Corporation"),
    Stock(symbol: "NFLX", price: 458.15, companyName: "Netflix Inc."),
    Stock(symbol: "AMD", price: 118.69, companyName: "Advanced Micro Devices"),
    Stock(symbol: "INTC", price: 43.27, companyName: "Intel Corporation"),
    Stock(symbol: "ORCL", price: 112.89, companyName: "Oracle Corporation"),
    Stock(symbol: "CRM", price: 265.43, companyName: "Salesforce Inc."),
    Stock(symbol: "ADBE", price: 562.18, companyName: "Adobe Inc."),
    Stock(symbol: "CSCO", price: 51.76, companyName: "Cisco Systems Inc."),
    Stock(symbol: "IBM", price: 168.92, companyName: "IBM Corporation"),
    Stock(symbol: "QCOM", price: 156.33, companyName: "QUALCOMM Inc."),
    Stock(symbol: "TXN", price: 189.45, companyName: "Texas Instruments"),
    Stock(symbol: "AVGO", price: 892.67, companyName: "Broadcom Inc."),
    Stock(symbol: "NOW", price: 678.23, companyName: "ServiceNow Inc."),
    Stock(symbol: "SNOW", price: 145.89, companyName: "Snowflake Inc."),
    Stock(symbol: "PYPL", price: 62.45, companyName: "PayPal Holdings"),
    Stock(symbol: "SQ", price: 68.91, companyName: "Block Inc."),
    Stock(symbol: "SHOP", price: 72.34, companyName: "Shopify Inc."),
    Stock(symbol: "UBER", price: 61.28, companyName: "Uber Technologies"),
    Stock(symbol: "LYFT", price: 13.56, companyName: "Lyft Inc.")
]

// MARK: - Feed Screen
struct FeedScreen: View {
    var body: some View {
        NavigationView {
            List(stocks) { stock in
                StockRow(stock: stock)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Stock Feed")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeedScreen()
}
