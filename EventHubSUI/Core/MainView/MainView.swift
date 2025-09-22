//
//  MainView.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct MainView: View {
    
    
    @State private var selectedTab: TabBookmarksEnum = .exploreView
    @State var router: Router
    @State var authManager: AuthManager
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ExploreView(viewModel: ExploreViewModel(router: router), events: Event.events)
                    .tag(TabBookmarksEnum.exploreView)
                    .toolbar(.hidden, for: .tabBar)
                
                EventsView(viewModel: EventsViewModel(router: router))
                    .tag(TabBookmarksEnum.eventsView)
                    .toolbar(.hidden, for: .tabBar)
                FavoritesView(vm: FavoritesViewModel(router: router))
                    .tag(TabBookmarksEnum.favoritesView)
                    .toolbar(.hidden, for: .tabBar)
                MapView(viewModel: MapViewModel(router: router))
                    .tag(TabBookmarksEnum.mapView)
                    .toolbar(.hidden, for: .tabBar)
                ProfileView(profileVM: ProfileViewModel(authManager: authManager, router: router))
                    .tag(TabBookmarksEnum.profileView)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(.keyboard)
        
        
    }
    
}

#Preview {
    MainView(router: Router(), authManager: AuthManager())
}
