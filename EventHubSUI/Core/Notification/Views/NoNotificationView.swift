//
//  NoNotificationView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 22.09.2025.
//

import SwiftUI

struct NoNotificationsView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(.notification)
                .font(.largeTitle)
                .foregroundColor(.secondary)
            
            Text("No notifications yet")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("You’ll see updates here when they arrive.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    NoNotificationsView()
}
