//
//  UserLocation.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 12/09/2025.
//

import Foundation
import CoreLocation

struct UserLocation: Codable {
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
