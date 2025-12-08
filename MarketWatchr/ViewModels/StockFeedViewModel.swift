//
//  StockFeedViewModel.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import Foundation
import Combine

final class StockFeedViewModel: ObservableObject {
    @Published private(set) var stocks: [Stock] = []
    @Published private(set) var isConnected = false
    @Published private(set) var isFeedActive = false
    @Published private(set) var flashingStocks: Set<String> = []
    
    private let webSocketService: WebSocketServiceProtocol
    private let repository: StockRepository
    private var cancellables = Set<AnyCancellable>()
    private var updateTimer: AnyCancellable?
    private var flashTimers: [String: AnyCancellable] = [:]
    
    init(webSocketService: WebSocketServiceProtocol = WebSocketService(),
         repository: StockRepository = StockRepository()) {
        self.webSocketService = webSocketService
        self.repository = repository
        
        self.stocks = repository.getInitialStocks()
        
        setupSubscriptions()
    }
    
    // MARK: - Public Methods
    func toggleFeed() {
        if isFeedActive {
            stopFeed()
        } else {
            startFeed()
        }
    }
    
    // MARK: - Private Methods
    private func setupSubscriptions() {
        // Subscribe to connection state changes
        webSocketService.connectionStatePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
        
        // Subscribe to price updates from WebSocket
        webSocketService.messagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] priceUpdate in
                self?.handlePriceUpdate(priceUpdate)
            }
            .store(in: &cancellables)
    }
    
    private func startFeed() {
        isFeedActive = true
        webSocketService.connect()
        
        // Send price updates every 2 seconds
        updateTimer = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.generateAndSendPriceUpdates()
            }
    }
    
    private func stopFeed() {
        isFeedActive = false
        updateTimer?.cancel()
        updateTimer = nil
        webSocketService.disconnect()
        
        // Clear all flash timers
        flashTimers.forEach { $0.value.cancel() }
        flashTimers.removeAll()
        flashingStocks.removeAll()
    }
    
    private func generateAndSendPriceUpdates() {
        for stock in stocks {
            let changePercent = Double.random(in: -0.05...0.05)
            let newPrice = max(10, stock.price * (1 + changePercent))
            
            let update = PriceUpdate(symbol: stock.symbol, price: newPrice)
            webSocketService.send(update)
        }
    }
    
    private func handlePriceUpdate(_ update: PriceUpdate) {
        guard let index = stocks.firstIndex(where: { $0.symbol == update.symbol }) else {
            return
        }
        
        let updatedStock = stocks[index].updatingPrice(update.price)
        stocks[index] = updatedStock
        
        triggerFlash(for: update.symbol)
        
        // Sort by price (highest first)
        stocks.sort { $0.price > $1.price }
    }
    
    func getStock(bySymbol symbol: String) -> Stock? {
        return stocks.first(where: { $0.symbol == symbol })
    }
    
    func isFlashing(_ symbol: String) -> Bool {
        return flashingStocks.contains(symbol)
    }
    
    private func triggerFlash(for symbol: String) {
        // Cancel existing timer if any
        flashTimers[symbol]?.cancel()
        
        // Add to flashing set
        flashingStocks.insert(symbol)
        
        // Remove after 1 second
        flashTimers[symbol] = Just(())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.flashingStocks.remove(symbol)
                self?.flashTimers.removeValue(forKey: symbol)
            }
    }
}
