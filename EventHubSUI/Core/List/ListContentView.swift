//
//  ListContentView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct ListContentView: View {
    let events: [Event]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(events, id: \.id) { event in
                        ListCell(event: event)
                    }
                }
            }
            .navigationTitle("Events")
        }
    }
}

#Preview {
    ListContentView(events: Event.events)
}
