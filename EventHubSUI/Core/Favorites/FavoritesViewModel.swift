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
    
    private let repo: EventRepositoryProtocol

    init(repo: EventRepositoryProtocol = EventRepository()) {
        self.repo = repo
        loadFavorites()
    }
    
    func loadFavorites() {
        favorites = repo.getFavorites().uniqueSortedByDate()
    }
    
    var filteredFavorites: [Event] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let base: [Event]
        if q.isEmpty {
            base = favorites
        } else {
            base = favorites.filter { e in
                (e.title ?? "")
                    .lowercased()
                    .contains(q)
            }
        }
        
        return base.uniqueSortedByDate()
    }
    
    func toggleFavorite(_ event: Event) {
        repo.toggleFavorite(event: event)
        loadFavorites()
    }

}
