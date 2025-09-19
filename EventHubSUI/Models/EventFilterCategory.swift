//
//  EventFilterCategory.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 13.09.2025.
//

import Foundation

enum FilterCategory: String, CaseIterable {
    case today
    case films
    case list
    
    var title: String {
        switch self {
        case .today: "TODAY"
        case .films: "FILMS"
        case .list: "LISTS"
        }
    }
}
