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
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var tappedEvent: Event?
    
    @Published var upcomingEvents: [Event] = []
    
    init(router: Router) {
        self.router = router
        Task {
            await fetchUpcomingEvents()
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            let result = try await networkService.fetch(from: .getUpcomingEvents(.msk))
            self.upcomingEvents = result.results.removingDuplicates()
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error)")
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
        print("fff")
        router.goTo(to: .eventDetailScreen(event: event))
    }
}
