//
//  ExploreViewModel.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import Foundation

enum EventListType: Hashable {
    case today
    case movies
    case nearby
    case upcoming
    case category
}

@MainActor
final class ExploreViewModel: ObservableObject {

    private let networkService = NetworkService()
     private var eventRepository = EventRepository()
     
     let router: Router
     
     @Published var upcomingEvents: [Event] = []
     @Published var nearEvents: [Event] = []
     @Published var categoryEvents: [Event] = []
     @Published var todayEvents: [Event] = []
     @Published var movieEvents: [Event] = []
     
     @Published var isLoading = false
     @Published var isCategoryMode = false
     @Published var tappedEvent: Event?
    
    
    init(router: Router) {
        self.router = router
        Task {
            await fetchInitialEvents()
        }
    }
    //MARK: - Network
    
    /// Загружаем дефолтные данные
    func fetchInitialEvents(_ location: LocationsList = .msk) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let upcoming = networkService.fetch(from: .getUpcomingEvents(location))
            async let nearby = networkService.fetch(from: .getNearbyEvents(location))
            async let movie = networkService.fetch(from: .getMovies(location))
            async let today = networkService.fetch(from: .getTodayEvents(location))
            
            let (upcomingResult, nearbyResult, movieResult, todayResult) = try await (upcoming, nearby, movie, today)
            self.upcomingEvents = upcomingResult.results.removingDuplicates()
            self.nearEvents = nearbyResult.results.removingDuplicates()
            self.movieEvents = movieResult.results.removingDuplicates()
            self.todayEvents = todayResult.results
            self.isCategoryMode = false
        } catch {
            print("Ошибка при загрузке дефолтных событий: \(error)")
        }
    }
      
      /// Загружаем данные по категории
    func fetchEventsBy(category: EventCategory, location: LocationsList) async {
          isLoading = true
          defer { isLoading = false }
          
          do {
              self.categoryEvents = try await networkService.fetch(from: .getEventsBy(category, location)).results
                  .removingDuplicates()
              self.isCategoryMode = true
          } catch {
              print("Ошибка при загрузке событий по категории: \(error)")
          }
      }
    /// Загружаем данные по локкации
    func fetchEvents(for location: LocationsList) async {
          isLoading = true
          defer { isLoading = false }
          do {
              let events = try await networkService.fetch(from: .getEventBy(location))
              // используем и для "upcoming", и для "nearby", чтобы UI не ломался
              self.upcomingEvents = events.results.removingDuplicates()
              self.nearEvents = events.results.removingDuplicates()
              self.isCategoryMode = false
          } catch {
              print("Ошибка при загрузке событий по локации \(location): \(error)")
          }
      }

    /// Сбрасываем фильтр
    func resetToDefault(_ location: LocationsList) {
          Task {
              await fetchInitialEvents(location)
          }
      }
    //MARK: - Navigation
    
    func goToDetail(event: Event) {
        router.goTo(to: .eventDetailScreen(event: event))
    }
    
    /// TODAY, FILMS, See All
    func goToSeeAll(_ events: [Event], _ isLoading: Bool) {
        router.goTo(to: .seeAllScreen(events: events, isLoading: isLoading))
    }
    
    /// LIST
    func goToList(_ events: [Event]) {
        router.goTo(to: .listScreen(events: events))
    }
    
    func goToSeach(_ events: [Event]) {
        router.goTo(to: .searchScreen(events: events))
    }
    
    
    //MARK: - Favorites
    func isFavorite(_ event: Event) -> Bool {
        eventRepository.isFavorite(event: event)
    }
    
    func toggleFavorite(_ event: Event) {
        eventRepository.toggleFavorite(event: event)
        objectWillChange.send() // обновляем UI
    }

}

