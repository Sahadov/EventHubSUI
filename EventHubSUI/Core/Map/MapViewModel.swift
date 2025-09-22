//
//  MapViewModel.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 11/09/2025.
//

import Foundation
import MapKit
import CoreLocation

@MainActor
class MapViewModel: ObservableObject {
    private var networkService = NetworkService()
    private var repo = EventRepository()
    let router: Router
    
    @Published var searchText: String = ""
    
    @Published var currentLocation: LocationsList = .msk {
        didSet {
            mapRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: currentLocation.latitude,
                    longitude: currentLocation.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }
    
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var tappedEvent: Event?
    
    @Published var upcomingEvents: [Event] = []
    
    init(router: Router) {
        self.router = router
        self.currentLocation = SearchDataManager.shared.loadUserLocation() ?? .msk
        Task {
            await fetchUpcomingEvents(location: currentLocation)
        }
    }
    
    func fetchUpcomingEvents(location: LocationsList) async {
        do {
            let result = try await networkService.fetch(from: .getUpcomingEvents(location))
            self.upcomingEvents = result.results.removingDuplicates()
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error)")
        }
    }
    
    func fetchByCategory(category: EventCategory, location: LocationsList) async {
        do {
            let result = try await networkService.fetch(from: .getEventsBy(category, location))
            self.upcomingEvents = result.results.removingDuplicates()
        } catch {
            print("Ошибка при загрузке событий по категориям: \(error)")
        }
    }
    
    func isFavorite(_ event: Event) -> Bool {
        repo.isFavorite(event: event)
    }
        
    func toggleFavorite(_ event: Event) {
        repo.toggleFavorite(event: event)
        objectWillChange.send()
    }
    
    @MainActor func goToDetailedView(event: Event) {
        router.goTo(to: .eventDetailScreen(event: event))
    }
    
    @MainActor
    func updateLocation(_ location: LocationsList) {
        currentLocation = location
        Task {
            await fetchUpcomingEvents(location: location)
        }
    }
}
