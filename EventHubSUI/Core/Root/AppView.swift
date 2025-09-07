//
//  AppView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct AppView: View {

    @State var appState: Bool = true // change later
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
    }
}
