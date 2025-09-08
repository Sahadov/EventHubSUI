//
//  CustomTabBar.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabBookmarksEnum
    
    var body: some View {
        BottomTabBar(selectedTab: $selectedTab)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab: TabBookmarksEnum = .eventsView
        var body: some View {
            ZStack(alignment: .bottom) {
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
    return PreviewWrapper()
}
