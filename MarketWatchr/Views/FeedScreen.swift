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
    let description: String
}

// feed list
let stocks: [Stock] = [
    Stock(symbol: "AAPL", price: 178.25, companyName: "Apple Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "GOOGL", price: 142.50, companyName: "Alphabet Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "MSFT", price: 378.91, companyName: "Microsoft Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "AMZN", price: 153.38, companyName: "Amazon.com Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "TSLA", price: 242.84, companyName: "Tesla Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "META", price: 352.79, companyName: "Meta Platforms Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "NVDA", price: 495.22, companyName: "NVIDIA Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "NFLX", price: 458.15, companyName: "Netflix Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "AMD", price: 118.69, companyName: "Advanced Micro Devices", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "INTC", price: 43.27, companyName: "Intel Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "ORCL", price: 112.89, companyName: "Oracle Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "CRM", price: 265.43, companyName: "Salesforce Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "ADBE", price: 562.18, companyName: "Adobe Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "CSCO", price: 51.76, companyName: "Cisco Systems Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "IBM", price: 168.92, companyName: "IBM Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "QCOM", price: 156.33, companyName: "QUALCOMM Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "TXN", price: 189.45, companyName: "Texas Instruments", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "AVGO", price: 892.67, companyName: "Broadcom Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "NOW", price: 678.23, companyName: "ServiceNow Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "SNOW", price: 145.89, companyName: "Snowflake Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "PYPL", price: 62.45, companyName: "PayPal Holdings", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "SQ", price: 68.91, companyName: "Block Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "SHOP", price: 72.34, companyName: "Shopify Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "UBER", price: 61.28, companyName: "Uber Technologies", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience."),
    Stock(symbol: "LYFT", price: 13.56, companyName: "Lyft Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps. Mini apps are self-contained experiences that are built using web technologies like HTML5 and JavaScript. This program is designed to help developers who host mini apps grow their business and further the availability of mini apps on the App Store — all while providing a great customer experience.")
]

// MARK: - Feed Screen
struct FeedScreen: View {
    @State private var isConnected = false
    @State private var isFeedActive = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
                TopBar(isConnected: isConnected, isFeedActive: $isFeedActive)
                
                // symbol List
                List(stocks) { stock in
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
