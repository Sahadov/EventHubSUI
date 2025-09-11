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
    case theatre = "theatre"
    case festival = "festival"
    case lecture = "lecture"
    case masterClass = "master-class"
    case kids = "kids"
    case party = "party"
    case quest = "quest"
    case cinema = "cinema"
    case businessEvents = "business-events"
    case other = "other"
    
    var title: String {
        switch self {
        case .concert: return "Concert"
        case .exhibition: return "Exhibition"
        case .theatre: return "Theatre"
        case .festival: return "Festival"
        case .lecture: return "Lecture"
        case .masterClass: return "Master Class"
        case .kids: return "Kids"
        case .party: return "Party"
        case .quest: return "Quest"
        case .cinema: return "Cinema"
        case .businessEvents: return "Business"
        case .other: return "Other"
        }
    }
    var color: Color {
            switch self {
            case .concert: return Color(hex: "#F0635A")
            case .exhibition: return  Color(hex: "#F59762")
            case .theatre: return  Color(hex: "#29D697")
            case .festival: return Color(hex: "#46CDFB")
            case .lecture: return .green
            case .masterClass: return .pink
            case .kids: return .yellow
            case .party: return .cyan
            case .quest: return .mint
            case .cinema: return .indigo
            case .businessEvents: return .brown
            case .other: return .gray
            }
        }
        
        var iconName: String {
            switch self {
            case .concert: return "music.note"
            case .exhibition: return "paintpalette"
            case .theatre: return "theatermasks"
            case .festival: return "sun.max"
            case .lecture: return "book"
            case .masterClass: return "hammer"
            case .kids: return "figure.and.child.holdinghands"
            case .party: return "sparkles"
            case .quest: return "puzzlepiece"
            case .cinema: return "film"
            case .businessEvents: return "briefcase"
            case .other: return "questionmark.circle"
            }
        }
    
}
