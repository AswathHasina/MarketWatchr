//
//  WebSocketService.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import Foundation
import Combine

protocol WebSocketServiceProtocol {
    var messagePublisher: AnyPublisher<PriceUpdate, Never> { get }
    var connectionStatePublisher: AnyPublisher<Bool, Never> { get }
    func connect()
    func disconnect()
    func send(_ update: PriceUpdate)
}

final class WebSocketService: NSObject, WebSocketServiceProtocol {
    private let messageSubject = PassthroughSubject<PriceUpdate, Never>()
    private let connectionStateSubject = CurrentValueSubject<Bool, Never>(false)
    
    var messagePublisher: AnyPublisher<PriceUpdate, Never> {
        messageSubject.eraseToAnyPublisher()
    }
    
    var connectionStatePublisher: AnyPublisher<Bool, Never> {
        connectionStateSubject.eraseToAnyPublisher()
    }
    
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession?
    
    func connect() {
        let url = URL(string: "wss://ws.postman-echo.com/raw")!
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocketTask = urlSession?.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
        connectionStateSubject.send(false)
    }
    
    func send(_ update: PriceUpdate) {
        guard let jsonData = try? JSONEncoder().encode(update),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return
        }
        
        let message = URLSessionWebSocketTask.Message.string(jsonString)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket send error: \(error)")
            }
        }
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handleReceivedMessage(text)
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
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
            return
        }
        messageSubject.send(update)
    }
    
    deinit {
        disconnect()
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        connectionStateSubject.send(true)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        connectionStateSubject.send(false)
    }
}
