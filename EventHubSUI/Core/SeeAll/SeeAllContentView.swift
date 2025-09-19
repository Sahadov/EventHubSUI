//
//  SeeAllContentView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct SeeAllContentView: View {
    @Environment(\.dismiss) private var dismiss
    var events: [Event] = []
    var isLoading: Bool 
    
    var body: some View {
        ZStack {
            if !events.isEmpty {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(events) { event in
                            EventCard(event: event)
                        }
                    }
                    .padding()
                }
            }

            if events.isEmpty {
                if isLoading {
                    LoadingView()
                } else {
                    EmptyStateView()
                }
            }
        }
        .searchNavigationStyle(title: "Events") { dismiss() }
    }
}

// MARK: - Subviews

private struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("😔")
                .font(.system(size: 80))
            Text("No events found")
                .font(.title2)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Text("We couldn't find any events at the moment. Try again later!")
                .font(.body)
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview {
    Group {
        SeeAllContentView(events: [], isLoading: true)
            .previewDisplayName("Loading")
        SeeAllContentView(events: [], isLoading: false)
            .previewDisplayName("Empty")
        SeeAllContentView(events: Event.events, isLoading: false)
            .previewDisplayName("With Data")
    }
}
