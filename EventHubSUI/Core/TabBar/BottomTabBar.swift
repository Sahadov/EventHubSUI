//
//  BottomTabBar.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: TabBookmarksEnum

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBookmarksEnum.allCases, id: \.self) { tabs in
                if tabs == .favoritesView {
                    CentralButton(selected: $selectedTab, index: tabs)
                        .offset(y: -30)
                } else {
                    TabButton(tab: tabs, isSelected: selectedTab == tabs) {
                        selectedTab = tabs
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 60)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -3)
                .mask(Rectangle().padding(.top, -20))
                .ignoresSafeArea(edges: .bottom)
        )
    }
}



// MARK: - Preview
#Preview {
    struct BottomTabBarPreview: View {
        @State private var tab: TabBookmarksEnum = .eventsView
        var body: some View {
            BottomTabBar(selectedTab: $tab)
        }
    }
    return BottomTabBarPreview()
}
