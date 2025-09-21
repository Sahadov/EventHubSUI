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
    
    @Published var tappedEvent: Event?
    
    let repo: EventRepositoryProtocol
    let router: Router
    
    
    init(repo: EventRepositoryProtocol = EventRepository(), router: Router) {
        self.repo = repo
        self.router = router
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
    
    func isFavorite(_ event: Event) -> Bool {
        repo.isFavorite(event: event)
    }
    
    @MainActor func goToDetailedView(event: Event) {
        router.goTo(to: .eventDetailScreen(event: event))
    }

}
