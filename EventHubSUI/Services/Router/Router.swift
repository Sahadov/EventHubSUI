//
//  Router.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import Foundation
import SwiftUI


class Router: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func goTo(to route: Routes) {
        path.append(route)
    }
    
    func goBack() {
    
        if path.isEmpty { return }
        path.removeLast()
        
    }
    
    func goToRoot() {
        path.removeLast(path.count)
    }
    
    func popToView(count: Int) {
        path.removeLast(count)
    }
    
    
    
}

enum Routes: Hashable {

//    case signInScreen
//    case signUpScreen
//    case resetPasswordScreen
//    case eventDetailScreen
//    case searchScreen
//    case notificationScreen
//    case webViewScreen
    case profileScreen
    case mapScreen
    case favoritesScreen
    case eventsScreen
    case exploreScreen
    
    
}

