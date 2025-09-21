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
                
                AppView(router: router, validator: validator, authManager: authManager)
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.keyboard)
                    .navigationDestination(for: Routes.self) { route in
                        
                        switch route {
                        case .eventsScreen:
                            EventsView(viewModel: EventsViewModel(router: router))
                        case .profileScreen:
                            ProfileView(profileVM: ProfileViewModel(authManager: authManager, router: router))
                        case .mapScreen:
                            MapView(viewModel: MapViewModel(router: router))
                        case .favoritesScreen:
                            FavoritesView(vm: FavoritesViewModel(router: router))
                        case .exploreScreen:
                            MainView(router: router, authManager: authManager)
                        case .signInScreen:
                            SignInView(signInVM: SignInViewModel(authManager: authManager, validator: validator, router: router))
                        case .signUpScreen:
                            SignUpView(signUpVM: SignUpViewModel(authManager: authManager, validator: validator, router: router))
                        case .resetPasswordScreen:
                            ResetView(resetVM: ResetViewModel(validator: validator, router: router, authManager: authManager))
                        case .eventDetailScreen(let event):
                            EventDetailsView(event: event)
                        case .resetPasswordConfirmationScreen:
                            ResetViewConfirm(resetVM: ResetViewModel(validator: validator, router: router, authManager: authManager))
                        case .seeAllScreen(events: let events, isLoading: let loading):
                            SeeAllContentView(events: events, isLoading: loading)
                        case .listScreen(events: let events):
                            ListContentView(events: events)
                        case .searchScreen(events: let events):
                            SearchScreen(events: events)
                        case .notificationScreen:
                            
//TODO: GO to notification
                            
                            Text("Hey")
                        }
                        
                    }
                
            }
        }
    }
}
