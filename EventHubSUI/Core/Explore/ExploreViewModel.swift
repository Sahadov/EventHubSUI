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
    
    @Published var isLoading = false
    /// Флаг: показываем ли категорию вместо дефолтных списков
    @Published var isCategoryMode = false
    
    
    init() {
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
              let (upcomingResult, nearbyResult) = try await (upcoming, nearby)
              self.upcomingEvents = upcomingResult.results
              self.nearEvents = nearbyResult.results
              self.isCategoryMode = false
          } catch {
              print("Ошибка при загрузке дефолтных событий: \(error)")
          }
      }
      
      /// Загружаем данные по категории
      func fetchEventsBy(category: EventCategory) async {
          isLoading = true
          defer { isLoading = false }
          
          do {
              self.categoryEvents = try await networkService.fetch(from: .getEventsBy(category: category)).results
              self.isCategoryMode = true
          } catch {
              print("Ошибка при загрузке событий по категории: \(error)")
          }
      }

    func fetchEventsBy(filter: FilterCategory) {
        self.categoryEvents = upcomingEvents.filter { event in
            switch filter {
            case .isFree:
                print("Event \(event.title ?? "") isFree: \(String(describing: event.isFree))")
                return event.isFree ?? false
            case .films:
                return event.categories?.contains(where: { $0.lowercased() == "cinema" }) ?? false
            case .others:
                return !(event.categories?.contains(where: { $0.lowercased() == "cinema" }) ?? false)
            }
        }
        self.isCategoryMode = true
    }

    /// Сбрасываем фильтр
      func resetToDefault() {
          Task {
              await fetchInitialEvents()
          }
      }
}
