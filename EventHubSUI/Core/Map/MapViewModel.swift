//
//  MapViewModel.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 11/09/2025.
//

import Foundation

@MainActor
class MapViewModel: ObservableObject {
    private var networkService = NetworkService()
    
    @Published var upcomingEvents: [Event] = []
    
    init() {
        Task {
            await fetchUpcomingEvents()
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            let result = try await networkService.fetch(from: .getUpcomingEvents())
            self.upcomingEvents = result.results
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error)")
        }
        
    }
}
