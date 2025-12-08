//
//  MarketWatchrApp.swift
//  MarketWatchr
//
//  Created by Aswath on 25/11/25.
//

import SwiftUI

@main
struct MarketWatchrApp: App {
    @StateObject private var viewModel = StockFeedViewModel()
    
    var body: some Scene {
        WindowGroup {
            FeedScreen()
                .environmentObject(viewModel)
        }
    }
}
