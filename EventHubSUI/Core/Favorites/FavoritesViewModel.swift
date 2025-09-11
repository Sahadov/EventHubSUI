//
//  FavoritesViewModel.swift
//  EventHubSUI
//
//  Created by Артур  Арсланов on 10.09.2025.
//
import SwiftUI

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Event] = []
    @Published var query: String = ""

    init() {
        loadMocks()
    }
    
    var filteredFavorites: [Event] {
            let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            guard !q.isEmpty else { return favorites }
            return favorites.filter { e in
                let title = e.title.lowercased()
                return title.contains(q)
            }
        }

    func toggleFavorite(_ event: Event) {
        if let index = favorites.firstIndex(where: { $0.slug == event.slug }) {
            favorites.remove(at: index)
        } else {
            favorites.append(event)
        }
    }

    func loadMocks() {
        favorites = [Event.mockConcert, Event.mockExhibition, Event.mockMarathon,Event.mockMarathon]
    }
}
