//
//  AppView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct AppView: View {

    @State var appState: Bool = true // change later
    @State private var shouldOnboardingFinal = !OnboardingManager.onboardingFlag
    @State var router: Router
    @State var validator: ValidationManager
    @State var authManager: AuthManager
    
    
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState,
            tabbarView: {

                if shouldOnboardingFinal {
                    OnboardingView(shouldShowOnboarding: $shouldOnboardingFinal)
                        .transition(.opacity)
                } else {
                    if authManager.userSession != nil {
                        MainView(router: router, authManager: authManager)
                    } else {

                        SignInView(signInVM: SignInViewModel(authManager: authManager, validator: validator, router: router))
                    }
                }
            },
            onboardingView: {
                WelcomeView()
            }
        )
    }
}
