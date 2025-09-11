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
                if selectedTab == 0 {
                    upcomingView
                } else {
                    pastEventsView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut(duration: 0.35), value: selectedTab)
                
        }
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
        Text("Контент первой вкладки")
        .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
    }
    
    var pastEventsView: some View {
        Text("Контент второй вкладки")
            .font(.largeTitle)
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
