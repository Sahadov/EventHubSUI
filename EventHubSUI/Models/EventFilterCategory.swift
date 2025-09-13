//
//  EventFilterCategory.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 13.09.2025.
//

import Foundation

enum FilterCategory: String, CaseIterable {
    case isFree = "isFree"
    case films = "films"
    case others = "others"
    
    var title: String {
        switch self {
        case .isFree: "FREE"
        case .films: "FILMS"
        case .others: "OTHERS"
        }
    }
}
