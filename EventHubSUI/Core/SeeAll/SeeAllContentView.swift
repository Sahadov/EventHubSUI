//
//  SeeAllContentView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct SeeAllContentView: View {
    var events: [Event]
    
    var body: some View {
        ScrollView {
            ForEach(events, id: \.id) { event in
//                SeeAllCell(event: event)
                EventCard(event: event)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    SeeAllContentView(events: Event.events)
}
