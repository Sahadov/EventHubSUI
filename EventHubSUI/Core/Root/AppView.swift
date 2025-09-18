//
//  AppView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct AppView: View {

    @State var appState: Bool = true // change later
    @State var router: Router
    @State var validator: ValidationManager
    @State var authManager: AuthManager
    
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState,
            tabbarView: {
//                TabBarView()
//                MainView()
                SignInView(signInVM: SignInViewModel(authManager: authManager, validator: validator, router: router))
            },
            onboardingView: {
                WelcomeView()
            }
        )
    }
}
