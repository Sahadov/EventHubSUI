//
//  EventsViewModel.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 10/09/2025.
//

import Foundation

@MainActor
class EventsViewModel: ObservableObject {
    private var networkService = NetworkService()
    
    @Published var upcomingEvents: [Event] = []
    @Published var pastEvents: [Event] = []
    @Published var isLoading = false
    
    init() {
        Task {
            await fetchUpcomingEvents()
            await fetchPastEvents()
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            self.isLoading = true
            let result = try await networkService.fetch(from: .getUpcomingEvents())
            self.upcomingEvents = result.results
            self.isLoading = false
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error)")
        }
        
    }
    
    func fetchPastEvents() async {
        do {
            self.isLoading = true
            let result = try await networkService.fetch(from: .getPastEvents())
            self.pastEvents = result.results
            self.isLoading = false
        } catch {
            print("Ошибка при загрузке прошлых событий: \(error)")
        }
    }
}
