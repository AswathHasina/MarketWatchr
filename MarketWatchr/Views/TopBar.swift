//
//  TopBar.swift
//  MarketWatchr
//
//  Created by Aswath on 07/12/25.
//

import SwiftUI

struct TopBar: View {
    let isConnected: Bool
    @Binding var isFeedActive: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                Circle()
                    .fill(isConnected ? Color.green : Color.red)
                    .frame(width: 12, height: 12)
                Text(isConnected ? "Connected" : "Disconnected")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                print("🦋")
                isFeedActive.toggle()
            }) {
                Text(isFeedActive ? "Stop Feed" : "Start Feed")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(isFeedActive ? Color.red : Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 2, y: 2)
    }
}

#Preview {
    TopBar(isConnected: true, isFeedActive: .constant(true))
    TopBar(isConnected: false, isFeedActive: .constant(false))
}
