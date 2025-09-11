//
//  EventsViewModel.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 10/09/2025.
//

import Foundation

class EventsViewModel: ObservableObject {
    private var networkService = NetworkService()
    
    @Published var upcomingEvents: [Event] = []
    @Published var lastEvents: [Event] = []
    
    init() {
        Task {
            await fetchUpcomingEvents()
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            //let result = try await networkService.fetch(from: .getUpcomingEvents())
            //self.upcomingEvents = result.results
            self.upcomingEvents = [Event.mockConcert, Event.mockConcert, Event.mockConcert]
            print(self.upcomingEvents)
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error)")
        }
        
    }
    
    func fetchLastevents() async {
        do {
            let result = try await networkService.fetch(from: .getUpcomingEvents(lon: 55.7569, lat: 37.6151))
            self.lastEvents = result.results
        } catch {
            print("Ошибка при загрузке прошлых событий: \(error)")
        }
    }
}
