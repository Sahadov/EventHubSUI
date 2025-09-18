//
//  SearchViewModel.swift
//  EventHubSUI
//
//  Created by Артур  Арсланов on 16.09.2025.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var all: [Event]
    @Published var query: String = ""
    @Published private(set) var results: [Event] = []
    @Published var isLoading = false
    @Published var loadError: String?
    @Published var showFilterSheet = false

    private let networkService = NetworkService()

    init(events: [Event]) {
        self.all = events.uniqueSortedByDate()
        self.results = self.all
    }

    func fetchEvents() async {
        isLoading = true
        loadError = nil
        do {
            let resp = try await networkService.fetch(from: .getUpcomingEvents())
            all = resp.results.uniqueSortedByDate()
            applyFilter()
        } catch {
            loadError = error.localizedDescription
        }
        isLoading = false
    }

    func applyFilter() {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if q.isEmpty {
            results = all.sortedByDate()
            return
        }

        let filtered = all.filter { e in
            [e.title, e.object?.title, e.movie?.title]
                .compactMap { $0?.lowercased() }
                .contains { $0.contains(q) }
        }

        results = filtered.uniqueSortedByDate()
    }
}
