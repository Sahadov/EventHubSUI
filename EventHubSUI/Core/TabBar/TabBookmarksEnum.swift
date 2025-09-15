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
            return "compassLight"
        case .eventsView:
            return "eventsLight"
        case .favoritesView:
            return "BookMark"
        case .mapView:
            return "mapLight"
        case .profileView:
            return "profileLight"
        }
    }
    var iconSelected: String {
        
        switch self {
        case .exploreView:
            return "compass"
        case .eventsView:
            return "events"
        case .favoritesView:
            return "BookMark"
        case .mapView:
            return "map"
        case .profileView:
            return "profile"
        }
    }
    
}
