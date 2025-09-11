//
//  Event.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import Foundation
import MapKit

// MARK: - API Models
struct EventResponse: Codable {
    let results: [Event]
}

struct Event: Codable {
    let dates: [DateInfo]?
    let title: String?
    let place: Place?
    let description: String?
    let bodyText: String?
    let images: [EventImage]?
    let favoritesCount: Int?
    
    var coordinates: CLLocationCoordinate2D? {
        guard
            let lat = place?.coords?.lat,
            let lon = place?.coords?.lon
        else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    enum CodingKeys: String, CodingKey {
        case dates, title, place, description, images
        case bodyText       = "body_text"
        case favoritesCount = "favorites_count"
    }
}

struct DateInfo: Codable {
    let startDate: String?
    let endDate: String?
    let startTime: String?
    let endTime: String?
    
    enum CodingKeys: String, CodingKey {
        case startDate   = "start_date"
        case endDate     = "end_date"
        case startTime   = "start_time"
        case endTime     = "end_time"
    }
}

struct Place: Codable {
    let id: Int?
    let title: String?
    let address: String?
    let coords: Coordinates?
    let subway: String?
}

struct EventImage: Codable {
    let image: String?
    let thumbnails: Thumbnails?
    
    struct Thumbnails: Codable {
        let size640x384: String?
        let size144x96: String?
        
        enum CodingKeys: String, CodingKey {
            case size640x384 = "640x384"
            case size144x96  = "144x96"
        }
    }
}

struct Coordinates: Codable {
    let lat: Double?
    let lon: Double?
}

//MARK: - Extension Event with id

extension Event: Identifiable {
    var id: String {
        let t   = title ?? ""
        let pid = place?.id.map(String.init) ?? ""
        let d   = dates?.first?.startDate ?? ""
        
        let key = [t, pid, d].joined(separator: "|")
        return key.isEmpty ? UUID().uuidString : key
    }
}

// MARK: - MOCK DATA
extension EventResponse {
    static let mock = EventResponse(
        results: [
            .mockExhibition,
            .mockConcert,
            .mockMarathon
        ]
    )
}

extension Event {
    static let mockExhibition = Event(
        dates: [DateInfo(
            startDate: "2025-09-15",
            endDate: "2025-09-20",
            startTime: "10:00:00",
            endTime: "18:00:00"
        )],
        title: "Impressionist Art Exhibition",
        place: Place(
            id: 101,
            title: "State Hermitage",
            address: "Palace Square, 2",
            coords: Coordinates(lat: 59.9398, lon: 30.3146),
            subway: "Admiralteyskaya"
        ),
        description: "A collection of impressionist paintings from the late 19th century.",
        bodyText: "The exhibition brings together masterpieces from Monet, Renoir, and Degas...",
        images: [
            EventImage(
                image: "https://picsum.photos/600/400?1",
                thumbnails: EventImage.Thumbnails(
                    size640x384: "https://picsum.photos/640/384?1",
                    size144x96: "https://picsum.photos/144/96?1"
                )
            )
        ],
        favoritesCount: 120
    )
    
    static let mockConcert = Event(
        dates: [DateInfo(
            startDate: "2025-10-01",
            endDate: "2025-10-02",
            startTime: "18:00:00",
            endTime: "23:00:00"
        )],
        title: "Rock Festival 2025",
        place: Place(
            id: 202,
            title: "Luzhniki Stadium",
            address: "Luzhniki, 24",
            coords: Coordinates(lat: 55.7158, lon: 37.5537),
            subway: "Sportivnaya"
        ),
        description: "Annual open-air rock music festival.",
        bodyText: "Join thousands of fans for an unforgettable weekend of live performances...",
        images: [
            EventImage(
                image: "https://picsum.photos/600/400?2",
                thumbnails: EventImage.Thumbnails(
                    size640x384: "https://picsum.photos/640/384?2",
                    size144x96: "https://picsum.photos/144/96?2"
                )
            )
        ],
        favoritesCount: 340
    )
    
    static let mockMarathon = Event(
        dates: [DateInfo(
            startDate: "2025-11-05",
            endDate: "2025-11-05",
            startTime: "08:00:00",
            endTime: "14:00:00"
        )],
        title: "City Marathon",
        place: Place(
            id: 303,
            title: "Red Square",
            address: "Kremlin, Moscow",
            coords: Coordinates(lat: 55.7539, lon: 37.6208),
            subway: "Okhotny Ryad"
        ),
        description: "Annual city marathon open to runners of all levels.",
        bodyText: "Run through the heart of the city, enjoy the cheering crowds and beautiful views...",
        images: [
            EventImage(
                image: "https://picsum.photos/600/400?3",
                thumbnails: EventImage.Thumbnails(
                    size640x384: "https://picsum.photos/640/384?3",
                    size144x96: "https://picsum.photos/144/96?3"
                )
            )
        ],
        favoritesCount: 540
    )
}
