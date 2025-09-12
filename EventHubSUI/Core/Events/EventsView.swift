//
//  EventsView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var viewModel = EventsViewModel()
    @State private var selectedTab = 0
    @Namespace private var animation
        
    var body: some View {
        VStack {
            controls
                
            Spacer()
                
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentBlue))
                    .scaleEffect(1.5)
                }
                
                ScrollView {
                    if selectedTab == 0 {
                        upcomingView
                    } else {
                        pastEventsView
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut(duration: 0.35), value: selectedTab)
            
            CustomSIButton(buttonLableText: "EXPLORE EVENTS")
                .padding(.vertical, 20)
            
            Spacer()
                
        }
        .background(Color.gray.opacity(0.1))
    }
    
    var controls: some View {
        HStack(spacing: 0) {
            CustomSegment(title: "UPCOMING", tag: 0,
                selection: $selectedTab,
                animation: animation)
                        
            CustomSegment(title: "PAST EVENTS", tag: 1,
                selection: $selectedTab,
                animation: animation)
        }
        .padding(4)
        .background(Color.gray.opacity(0.1))
        .clipShape(Capsule())
        .padding(.horizontal, 50)
        .padding(.top, 8)
    }
    
    var upcomingView: some View {
        VStack {
            ForEach(Array(viewModel.upcomingEvents.enumerated()), id: \.element.title) { _, event in
                EventCard(event: event)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
    }
    
    var pastEventsView: some View {
        VStack {
            ForEach(Array(viewModel.pastEvents.enumerated()), id: \.element.title) { _, event in
                EventCard(event: event)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
        .transition(.asymmetric(
            insertion: .move(edge: .leading).combined(with: .opacity),
            removal: .move(edge: .trailing).combined(with: .opacity)
        ))
    }
}


struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
