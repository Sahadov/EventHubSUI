//
//  MainView.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var router = Router()
    @State private var selectedTab: TabBookmarksEnum = .exploreView
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    ExploreView()
                        .tag(TabBookmarksEnum.exploreView)
                        .toolbar(.hidden, for: .tabBar)
                    EventsView()
                        .tag(TabBookmarksEnum.eventsView)
                        .toolbar(.hidden, for: .tabBar)
                    FavoritesView()
                        .tag(TabBookmarksEnum.favoritesView)
                        .toolbar(.hidden, for: .tabBar)
                    MapView()
                        .tag(TabBookmarksEnum.mapView)
                        .toolbar(.hidden, for: .tabBar)
                    ProfileView()
                        .tag(TabBookmarksEnum.profileView)
                        .toolbar(.hidden, for: .tabBar)
                }
                .padding(.top, selectedTab.title.isEmpty ? 0 : 50)
                
                if !selectedTab.title.isEmpty {
                    VStack {
                        CustomNavBar(title: selectedTab.title)
                        Spacer()
                    }
                }
                
                CustomTabBar(selectedTab: $selectedTab)
            }
            
            .navigationBarHidden(true)
            .ignoresSafeArea(.keyboard)
            .navigationDestination(for: Routes.self) { route in
                
                switch route {
                case .eventsScreen:
                    EventsView()
                case .profileScreen:
                    ProfileView()
                case .mapScreen:
                    MapView()
                case .favoritesScreen:
                    FavoritesView()
                case .exploreScreen:
                    ExploreView()
                }
                
            }
            
        }
        
    }
}

#Preview {
    MainView()
}
