//
//  StockFeedViewModel.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import SwiftUI

let stockData: [String: (name: String, description: String)] = [
    "AAPL": ("Apple Inc.", "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. The company is known for its iPhone, Mac, iPad, and Apple Watch products."),
    "GOOGL": ("Alphabet Inc.", "Alphabet Inc. provides various products and services globally, including Google Search, ads, Android, Chrome, Google Cloud, YouTube, and hardware products like Pixel phones."),
    "MSFT": ("Microsoft Corporation", "Microsoft Corporation develops, licenses, and supports software, services, devices, and solutions worldwide. Products include Windows, Office, Azure cloud services, and Xbox gaming platform."),
    "AMZN": ("Amazon.com Inc.", "Amazon.com Inc. is a multinational technology company focusing on e-commerce, cloud computing, digital streaming, and artificial intelligence through Amazon Web Services and retail operations."),
    "TSLA": ("Tesla Inc.", "Tesla Inc. designs, develops, manufactures, and sells electric vehicles and energy generation and storage systems. The company is a leader in sustainable energy and autonomous driving technology."),
    "META": ("Meta Platforms Inc.", "Meta Platforms Inc. operates social networking platforms including Facebook, Instagram, WhatsApp, and Messenger. The company is investing heavily in virtual and augmented reality technologies."),
    "NVDA": ("NVIDIA Corporation", "NVIDIA Corporation provides graphics processing units, chipsets, and related multimedia software. The company leads in AI computing, gaming graphics, and data center solutions."),
    "NFLX": ("Netflix Inc.", "Netflix Inc. provides entertainment services with streaming of TV series, documentaries, and feature films across various genres and languages globally through subscription-based model.")
]


class StockFeedViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var isConnected = false
    @Published var isFeedActive = false
    
    private var timer: Timer?
    private let symbols = ["AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NVDA", "NFLX"]
    
    init() {
        initializeStocks()
    }
    
    private func initializeStocks() {
        stocks = symbols.map { symbol in
            let price = Double.random(in: 50...500)
            let data = stockData[symbol] ?? (name: symbol, description: "No description available.")
            return Stock(
                symbol: symbol,
                price: price,
                previousPrice: price,
                companyName: data.name,
                description: data.description
            )
        }
        sortStocks()
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
        isConnected = true
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.updatePrices()
        }
    }
    
    private func stopFeed() {
        isConnected = false
        timer?.invalidate()
        timer = nil
    }
    
    private func updatePrices() {
        for i in stocks.indices {
            let change = Double.random(in: -10...10)
            stocks[i].previousPrice = stocks[i].price
            stocks[i].price = max(10, stocks[i].price + change)
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
