//
//  TabBookmarksEnum.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import Foundation
import SwiftUI

enum TabBookmarksEnum: Int, CaseIterable {
    
    case exploreView, eventsView, favoritesView, mapView, profileView
    
    var icon: String {
        
        switch self {
        case .exploreView:
            return "eyes"
        case .eventsView:
            return "bubble.left.and.bubble.right.fill"
        case .favoritesView:
            return "bookmark"
        case .mapView:
            return "person.fill"
        case .profileView:
            return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .exploreView:
            return "Explore"
        case .eventsView:
            return "Events"
        case .favoritesView:
            return "Favorites"
        case .mapView:
            return "Map"
        case .profileView:
            return "Profile"
        }
    }
    
}
