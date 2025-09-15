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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                
                AppView(router: router)
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
                            MainView(router: router)
                        case .signInScreen:
                            SignInView(signInVM: SignInViewModel(router: router))
                        case .signUpScreen:
                            SignUpView()
                        case .resetPasswordScreen:
                            ResetView()
                        case .eventDetailScreen(let event):
                            EventDetailsView(event: event)
                        case .resetPasswordConfirmationScreen:
                            ResetViewConfirm()
                        }
                        
                    }
                
            }
        }
    }
}
