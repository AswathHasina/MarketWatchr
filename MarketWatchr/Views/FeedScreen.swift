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
    var price: Double
    var previousPrice: Double
    let companyName: String
    let description: String
    var priceChange: Double {
        price - previousPrice
    }
    
    var isUp: Bool {
        priceChange >= 0
    }
}

// feed list
var initialStocks: [Stock] = [
    Stock(symbol: "AAPL", price: 178.25, previousPrice: 178.25, companyName: "Apple Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "GOOGL", price: 142.50, previousPrice: 142.50, companyName: "Alphabet Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "MSFT", price: 378.91, previousPrice: 378.91, companyName: "Microsoft Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "AMZN", price: 153.38, previousPrice: 153.38, companyName: "Amazon.com Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "TSLA", price: 242.84, previousPrice: 242.84, companyName: "Tesla Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps.."),
    Stock(symbol: "META", price: 352.79, previousPrice: 352.79, companyName: "Meta Platforms Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "NVDA", price: 495.22, previousPrice: 495.22, companyName: "NVIDIA Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "NFLX", price: 458.15, previousPrice: 458.15, companyName: "Netflix Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "AMD", price: 118.69, previousPrice: 118.69, companyName: "Advanced Micro Devices", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "INTC", price: 43.27, previousPrice: 43.27, companyName: "Intel Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "ORCL", price: 112.89, previousPrice: 112.89, companyName: "Oracle Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "CRM", price: 265.43, previousPrice: 265.43, companyName: "Salesforce Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "ADBE", price: 562.18, previousPrice: 562.18, companyName: "Adobe Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "CSCO", price: 51.76, previousPrice: 51.76, companyName: "Cisco Systems Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "IBM", price: 168.92, previousPrice: 168.92, companyName: "IBM Corporation", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "QCOM", price: 156.33, previousPrice: 156.33, companyName: "QUALCOMM Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "TXN", price: 189.45, previousPrice: 189.45, companyName: "Texas Instruments", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "AVGO", price: 892.67, previousPrice: 892.67, companyName: "Broadcom Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "NOW", price: 678.23, previousPrice: 678.23, companyName: "ServiceNow Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "SNOW", price: 145.89, previousPrice: 145.89, companyName: "Snowflake Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "PYPL", price: 62.45, previousPrice: 62.45, companyName: "PayPal Holdings", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "SQ", price: 68.91, previousPrice: 68.91, companyName: "Block Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "SHOP", price: 72.34, previousPrice: 72.34, companyName: "Shopify Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "UBER", price: 61.28, previousPrice: 61.28, companyName: "Uber Technologies", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps."),
    Stock(symbol: "LYFT", price: 13.56, previousPrice: 13.56, companyName: "Lyft Inc.", description: "Today, we’re introducing the Mini Apps Partner Program, which expands on the App Store’s ongoing support for apps that offer mini apps.")
]

class StockFeedViewModel: ObservableObject {
    @Published var stocks: [Stock]
    @Published var isConnected = false
    @Published var isFeedActive = false
    
    private var timer: Timer?
    
    init() {
        self.stocks = initialStocks
    }
    
    func toggleFeed() {
        isFeedActive.toggle()
        
        if isFeedActive {
            startFeed()
        } else {
            stopFeed()
        }
    }
    
    private func startFeed() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.updatePrices()
        }
    }
    
    private func stopFeed() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updatePrices() {
        for i in stocks.indices {
            let currentPrice = stocks[i].price
            // Generate a small price change (-5% to +5%)
            let changePercent = Double.random(in: -0.05...0.05)
            let newPrice = max(10, currentPrice * (1 + changePercent))
            
            stocks[i].previousPrice = stocks[i].price
            stocks[i].price = newPrice
        }
        sortStocks()
    }
    
    private func sortStocks() {
        stocks.sort { $0.price > $1.price }
    }
    
    deinit {
        timer?.invalidate()
    }
}


// MARK: - Feed Screen
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
