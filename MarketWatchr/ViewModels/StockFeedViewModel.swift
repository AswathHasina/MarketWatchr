//
//  StockFeedViewModel.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import Foundation
import Combine

class StockFeedViewModel: NSObject, ObservableObject, URLSessionWebSocketDelegate {
    @Published var stocks: [Stock]
    @Published var isConnected = false
    @Published var isFeedActive = false
    
    private var webSocketTask: URLSessionWebSocketTask?
    private var timer: Timer?
    
    override init() {
        self.stocks = initialStocks
        super.init()
    }
    
    func toggleFeed() {
        isFeedActive.toggle()
        
        if isFeedActive {
            connect()
        } else {
            disconnect()
        }
    }
    
    private func connect() {
        let url = URL(string: "wss://ws.postman-echo.com/raw")!
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        // Start listening for messages
        receiveMessage()
        
        // Start timer to send price updates every 2 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.sendPriceUpdates()
        }
    }
    
    private func disconnect() {
        timer?.invalidate()
        timer = nil
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
        isConnected = false
    }
    
    private func sendPriceUpdates() {
        for i in stocks.indices {
            let currentPrice = stocks[i].price
            // Generate a small price change (-5% to +5%)
            let changePercent = Double.random(in: -0.05...0.05)
            let newPrice = max(10, currentPrice * (1 + changePercent))
            
            let update = PriceUpdate(
                symbol: stocks[i].symbol,
                price: newPrice
            )
            
            // Encode and send via WebSocket
            if let jsonData = try? JSONEncoder().encode(update),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                let message = URLSessionWebSocketTask.Message.string(jsonString)
                webSocketTask?.send(message) { error in
                    if let error = error {
                        print("WebSocket send error: \(error)")
                    }
                }
            }
        }
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("MESSAGE 👾: \(text)")
                    self?.handleReceivedMessage(text)
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
                        print("MESSAGE 🥶: \(text)")
                        self?.handleReceivedMessage(text)
                    }
                @unknown default:
                    break
                }

                self?.receiveMessage()
            case .failure(let error):
                print("WebSocket receive error: \(error)")
            }
        }
    }
    
    private func handleReceivedMessage(_ message: String) {
        guard let data = message.data(using: .utf8),
              let update = try? JSONDecoder().decode(PriceUpdate.self, from: data) else {
            print("unable to decode message")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let index = self.stocks.firstIndex(where: { $0.symbol == update.symbol }) {
                self.stocks[index].previousPrice = self.stocks[index].price
                self.stocks[index].price = update.price
                self.sortStocks()
            }
        }
    }
    
    private func sortStocks() {
        stocks.sort { $0.price > $1.price }
    }
    
    // MARK: - URLSessionWebSocketDelegate
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        DispatchQueue.main.async {
            self.isConnected = true
            print("CONNECTED 🟢")
        }
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        DispatchQueue.main.async {
            self.isConnected = false
            print("DISCONNECTED 🔴")
        }
    }
    
    deinit {
        disconnect()
    }

}
