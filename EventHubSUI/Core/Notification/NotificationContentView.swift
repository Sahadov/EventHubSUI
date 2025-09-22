//
//  NotificationContentView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 22.09.2025.
//

import SwiftUI

struct NotificationContentView: View {
    @State private var notifications: [NotificationItem] = []
    
    var body: some View {
        if notifications.isEmpty {
            NoNotificationsView()
        } else {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(notifications) { item in
                        NotoficationView(item: item)
                    }
                }
                .padding(.top, 12)
            }
        }
    }
}

#Preview {
    NotificationContentView()
}
