//
//  Routes.swift
//  EventHubSUI
//
//  Created by Sergey on 15.09.2025.
//

import Foundation
enum Routes: Hashable {
    case signInScreen
    case signUpScreen
    case resetPasswordScreen
    case resetPasswordConfirmationScreen
    case eventDetailScreen(event: Event)
    case seeAllScreen(events: [Event])
    case listScreen(events: [Event])
//    case searchScreen
//    case notificationScreen
//    case webViewScreen
    case profileScreen
    case mapScreen
    case favoritesScreen
    case eventsScreen
    case exploreScreen

}
