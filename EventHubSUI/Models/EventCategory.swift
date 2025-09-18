//
//  EventCategory.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import SwiftUI

enum EventCategory: String, CaseIterable {
    case all /// Сброс по умолчанию
    case concert = "concert"
    case exhibition = "exhibition"
    case festival = "festival"
    case kids = "kids"
    case party = "party"
    case quest = "quest"
    
    var title: String {
        switch self {
        case .all: return "All"
        case .concert: return "Concert"
        case .exhibition: return "Exhibition"
        case .festival: return "Festival"
        case .kids: return "Kids"
        case .party: return "Party"
        case .quest: return "Quest"
        }
    }
    var color: Color {
        switch self {
        case .all: return Color(hex: "#F0635A")
        case .concert: return Color(hex: "#F59762")
        case .exhibition: return Color(hex: "#29D697")
        case .festival: return Color(hex: "#46CDFB")
        case .kids: return .cyan
        case .party: return .mint
        case .quest: return .purple
            
        }
    }
    
    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .concert: return "music.note"
        case .exhibition: return "paintpalette"
        case .festival: return "sun.max"
        case .kids: return "figure.and.child.holdinghands"
        case .party: return "sparkles"
        case .quest: return "puzzlepiece"
        }
    }
    
}
