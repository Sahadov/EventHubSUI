//
//  NotoficationView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 22.09.2025.
//

import SwiftUI

struct NotoficationView: View {
    let item: NotificationItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.Airbnb.light(size: 15))
                .foregroundColor(.primary)
            
            Text(item.subtitle)
                .font(.Airbnb.light(size: 15))
                .foregroundColor(.primary)
            
            Text(item.time)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.horizontal, 12)
    }
}


#Preview {
    let sampleItem = NotificationItem(
        title: "International Band Music Concert",
        subtitle: "Incoming soon!",
        time: "Just now"
    )
    
    ZStack {
        VStack {
            NotoficationView(item: sampleItem)
        }
    }
}

