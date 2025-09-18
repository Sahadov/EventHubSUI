//
//  EventHubSUIApp.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct EventHubSUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var router = Router()
    @StateObject private var validator = ValidationManager()
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                
                AppView(router: router, validator: validator)
                    .environmentObject(authManager)
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.keyboard)
                    .navigationDestination(for: Routes.self) { route in
                        
                        switch route {
                        case .eventsScreen:
                            EventsView()
                        case .profileScreen:
                            ProfileView(profileVM: ProfileViewModel(authManager: authManager, router: router))
                        case .mapScreen:
                            MapView()
                        case .favoritesScreen:
                            FavoritesView()
                        case .exploreScreen:
                            MainView(router: router, authManager: authManager)
                        case .signInScreen:
                            SignInView(signInVM: SignInViewModel(authManager: authManager, validator: validator, router: router))
                        case .signUpScreen:
                            SignUpView(signUpVM: SignUpViewModel(authManager: authManager, validator: validator, router: router))
                        case .resetPasswordScreen:
                            ResetView(resetVM: ResetViewModel(validator: validator, router: router))
                        case .eventDetailScreen(let event):
                            EventDetailsView(event: event)
                        case .resetPasswordConfirmationScreen:
                            ResetViewConfirm(resetVM: ResetViewModel(validator: validator, router: router))
                        case .seeAllScreen(events: let events):
                            SeeAllContentView(events: events)
                        case .listScreen(events: let events):
                            ListContentView(events: events)
                        case .searchScreen(events: let events):
                            SearchScreen(events: events)
                        }
                        
                    }
                
            }
        }
    }
}
