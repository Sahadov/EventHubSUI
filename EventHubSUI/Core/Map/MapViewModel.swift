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
    @Published var searchText: String = ""
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var tappedEvent: Event?
    
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
