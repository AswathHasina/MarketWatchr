//
//  Stock.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import Foundation

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
