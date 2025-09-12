//
//  TabBarView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ExploreView(events: Event.events)
                .tabItem {
                    Label("Explore", systemImage: "eyes")
                }
            EventsView()
                .tabItem {
                    Label("Events", systemImage: "bubble.left.and.bubble.right.fill")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "person.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}
