//
//  EventCategory.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import SwiftUI

enum EventCategory: String, CaseIterable {
    case concert = "concert"
    case exhibition = "exhibition"
    case festival = "festival"
    case kids = "kids"
    case party = "party"
    case quest = "quest"
    case businessEvents = "business-events"
    
    var title: String {
        switch self {
        case .concert: return "Concert"
        case .exhibition: return "Exhibition"
        case .festival: return "Festival"
        case .kids: return "Kids"
        case .party: return "Party"
        case .quest: return "Quest"
        case .businessEvents: return "Business"
        }
    }
    var color: Color {
        switch self {
        case .concert: return Color(hex: "#F0635A")
        case .exhibition: return  Color(hex: "#F59762")
        case .festival: return Color(hex: "#29D697")
        case .kids: return Color(hex: "#46CDFB")
        case .party: return .cyan
        case .quest: return .mint
        case .businessEvents: return .brown
            
        }
    }
    
    var iconName: String {
        switch self {
        case .concert: return "music.note"
        case .exhibition: return "paintpalette"
        case .festival: return "sun.max"
        case .kids: return "figure.and.child.holdinghands"
        case .party: return "sparkles"
        case .quest: return "puzzlepiece"
        case .businessEvents: return "briefcase"
        }
    }
    
}
