//
//  ExploreViewModel.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import Foundation

@MainActor
final class ExploreViewModel: ObservableObject {
    private let networkService = NetworkService()
    
    @Published var upcomingEvents: [Event] = []
    @Published var nearEvents: [Event] = []
    @Published var categoryEvents: [Event] = []
    @Published var locationEvents: [Event] = []
    @Published var todayEvents: [Event] = []
    @Published var movieEvents: [Event] = []
    
    @Published var isLoading = false
    /// Флаг: показываем ли категорию вместо дефолтных списков
    @Published var isCategoryMode = false
    
    let router: Router
    
    init(router: Router) {
        self.router = router
        Task {
            await fetchInitialEvents()
        }
    }
    
    /// Загружаем дефолтные данные
    func fetchInitialEvents() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let upcoming = networkService.fetch(from: .getUpcomingEvents())
            async let nearby = networkService.fetch(from: .getNearbyEvents())
            async let movie = networkService.fetch(from: .getMovies())
            async let today = networkService.fetch(from: .getTodayEvents())
            
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

//    func fetchEventsBy(filter: FilterCategory, location: LocationsList) async {
//        isLoading = true
//        defer { isLoading = false }
//        
//        switch filter {
//        case .films:
//            do {
//                self.movieEvents = try await networkService.fetch(from: .getMovies(location)).results
//            } catch {
//                print("Ошибка при загрузке событий по категории: \(error)")
//            }
//            
//        case .today:
//            do {
//                self.todayEvents = try await networkService.fetch(from: .getTodayEvents(location)).results
//            } catch {
//                print("Ошибка при загрузке событий по категории: \(error)")
//            }
//            
//        case .list:
//            break
//        }
//    }

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
      func resetToDefault() {
          Task {
              await fetchInitialEvents()
          }
      }
    
    func goToDetail(event: Event) {
        router.goTo(to: .eventDetailScreen(event: event))
    }
}
