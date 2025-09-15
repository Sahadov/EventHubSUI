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
    let poster: EventImage?
    let publicationDate: Double?
    let favoritesCount: Int?
    let categories: [String]?
    let isFree: Bool?
    
    // Для movie-showings
    let datetime: Double?
    let movie: Movie?
    
    // Для today events
    let object: TodayEventObject?
    
    var coordinates: CLLocationCoordinate2D? {
        if let lat = place?.coords?.lat, let lon = place?.coords?.lon {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        if let lat = object?.place?.coords?.lat, let lon = object?.place?.coords?.lon {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case dates, title, place, description, images, categories, poster, movie, datetime, object
        case bodyText = "body_text"
        case favoritesCount = "favorites_count"
        case isFree = "is_free"
        case publicationDate = "publication_date"
    }
}

// MARK: - Movie structure
struct Movie: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let bodyText: String?
    let poster: EventImage?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, poster
        case bodyText = "body_text"
    }
}

struct DateInfo: Codable {
    let startDate: String?
    let endDate: String?
    let startTime: String?
    let endTime: String?
    let start: Double?
    let end: Double?
    
    enum CodingKeys: String, CodingKey {
        case start, end
        case startDate = "start_date"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

struct TodayEventObject: Codable {
    let dates: [DateInfo]?
    let title: String?
    let place: Place?
    let description: String?
    let bodyText: String?
    let images: [EventImage]?
    let poster: EventImage?
    let first_image: EventImage?
}

// MARK: - Place
struct Place: Codable {
    let id: Int?
    let title: String?
    let slug: String?
    let address: String?
    let phone: String?
    let isStub: Bool?
    let siteURL: String?
    let coords: Coordinates?
    
    enum CodingKeys: String, CodingKey {
        case id, title, slug, address, phone
        case isStub = "is_stub"
        case siteURL = "site_url"
        case coords
    }
}

struct EventImage: Codable {
    let image: String?
    let thumbnails: Thumbnails?
    
    struct Thumbnails: Codable {
        let size640x384: String?
        let size144x96: String?
        
        enum CodingKeys: String, CodingKey {
            case size640x384 = "640x384"
            case size144x96 = "144x96"
        }
    }
}

struct Coordinates: Codable {
    let lat: Double?
    let lon: Double?
}

// MARK: - Identifiable
extension Event: Identifiable {
    var id: String {
        let t = title ?? object?.title ?? movie?.title ?? ""
        let pid = place?.id.map(String.init) ?? object?.place?.id.map(String.init) ?? ""
        let d = dates?.first?.startDate ?? object?.dates?.first?.startDate ?? ""
        let key = [t, pid, d].joined(separator: "|")
        return key.isEmpty ? UUID().uuidString : key
    }
}

// MARK: - Date Formatting
extension DateInfo {
    var day: String {
        guard let start = start else { return "" }
        let date = Date(timeIntervalSince1970: start)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    var month: String {
        guard let start = start else { return "" }
        let date = Date(timeIntervalSince1970: start)
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date).capitalized
    }
}

extension Event {
    var firstStartTimestamp: Double? {
        if let start = dates?.first?.start { return start }
        if let start = object?.dates?.first?.start { return start }
        if let start = datetime { return start }
        return nil
    }
    
    var formattedStartDate: String {
        guard let ts = firstStartTimestamp else { return "" }
        let date = Date(timeIntervalSince1970: ts)
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM h:mm a" // такой же, как в листе
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}

// MARK: - Event Extensions
extension Event {
    
    var nextDate: DateInfo? {
        guard let dates = dates else { return nil }
        let now = Date().timeIntervalSince1970
        let validDates = dates.filter { date in
            if let start = date.start, let end = date.end {
                return start > 0 && end > 0 && start >= now
            }
            return false
        }
        return validDates.sorted { ($0.start ?? 0) < ($1.start ?? 0) }.first
    }
    
    var displayTitle: String {
        object?.title ?? movie?.title ?? title ?? "Unknown"
    }
    
    var displayImageURL: String? {
        if let posterImage = poster?.image { return posterImage }
        if let firstImage = images?.first?.image { return firstImage }
        if let objectPoster = object?.poster?.image { return objectPoster }
        if let objectImageFirst = object?.images?.first?.image { return objectImageFirst }
        if let objectFirstImage = object?.first_image?.image { return objectFirstImage }
        if let moviePoster = movie?.poster?.image { return moviePoster }
        return nil
    }
    
    var displayDate: Date? {
        if let datetime = datetime { return Date(timeIntervalSince1970: datetime) }
        if let start = dates?.first?.start { return Date(timeIntervalSince1970: start) }
        if let start = object?.dates?.first?.start { return Date(timeIntervalSince1970: start) }
        return nil
    }
    
    var locationName: String {
        object?.place?.title ?? place?.title ?? "Unknown location"
    }
    
    var locationAddress: String {
        object?.place?.address ?? place?.address ?? "No address"
    }
    
    var isEndless: Bool {
        guard let dates = dates else { return false }
        return dates.contains { ($0.start ?? 0) < 0 || ($0.end ?? 0) > 4102444800 }
    }
}

// MARK: - Mock Data
extension EventResponse {
    static let mock = EventResponse(
        results: [
            .mockExhibition,
            .mockConcert,
            .mockMarathon,
            .mockToday,
            .mockMovie
        ]
    )
}

extension Event {
    
    static let mockExhibition = Event(
        dates: [DateInfo(startDate: "2025-09-15", endDate: "2025-09-20", startTime: "10:00:00", endTime: "18:00:00", start: 1757907600, end: 1758226800)],
        title: "Impressionist Art Exhibition",
        place: Place(id: 101, title: "State Hermitage", slug: nil, address: "Palace Square, 2", phone: nil, isStub: nil, siteURL: nil, coords: Coordinates(lat: 59.9398, lon: 30.3146)),
        description: "A collection of impressionist paintings.",
        bodyText: "The exhibition brings together masterpieces from Monet, Renoir, and Degas...",
        images: [EventImage(image: "https://images.unsplash.com/photo-1504196606672-aef5c9cefc92", thumbnails: nil)],
        poster: EventImage(image: "https://images.unsplash.com/photo-1607746882042-944635dfe10e", thumbnails: nil),
        publicationDate: 1708045200,
        favoritesCount: 120,
        categories: ["Exhibition"],
        isFree: true,
        datetime: nil,
        movie: nil,
        object: nil
    )
    
    static let mockConcert = Event(
        dates: [DateInfo(startDate: "2025-10-01", endDate: "2025-10-02", startTime: "18:00:00", endTime: "23:00:00", start: 1759306800, end: 1759393200)],
        title: "Rock Festival 2025",
        place: Place(id: 202, title: "Luzhniki Stadium", slug: nil, address: "Luzhniki, 24", phone: nil, isStub: nil, siteURL: nil, coords: Coordinates(lat: 55.7158, lon: 37.5537)),
        description: "Annual open-air rock music festival.",
        bodyText: "Join thousands of fans for live performances...",
        images: [EventImage(image: "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2", thumbnails: nil)],
        poster: EventImage(image: "https://images.unsplash.com/photo-1607746882042-944635dfe10e", thumbnails: nil),
        publicationDate: 1708045200,
        favoritesCount: 340,
        categories: ["Concert"],
        isFree: true,
        datetime: nil,
        movie: nil,
        object: nil
    )
    
    static let mockMarathon = Event(
        dates: [DateInfo(startDate: "2025-11-05", endDate: "2025-11-05", startTime: "08:00:00", endTime: "14:00:00", start: 1759894800, end: 1759916400)],
        title: "City Marathon",
        place: Place(id: 303, title: "Red Square", slug: nil, address: "Kremlin, Moscow", phone: nil, isStub: nil, siteURL: nil, coords: Coordinates(lat: 55.7539, lon: 37.6208)),
        description: "Annual city marathon.",
        bodyText: "Run through the heart of the city...",
        images: [EventImage(image: "https://images.unsplash.com/photo-1546519638-68e109498ffc", thumbnails: nil)],
        poster: EventImage(image: "https://images.unsplash.com/photo-1607746882042-944635dfe10e", thumbnails: nil),
        publicationDate: 1708045200,
        favoritesCount: 540,
        categories: ["Marathon"],
        isFree: true,
        datetime: nil,
        movie: nil,
        object: nil
    )
    
    static let mockToday = Event(
        dates: nil,
        title: nil,
        place: nil,
        description: nil,
        bodyText: nil,
        images: nil,
        poster: nil,
        publicationDate: nil,
        favoritesCount: nil,
        categories: nil,
        isFree: nil,
        datetime: nil,
        movie: nil,
        object: TodayEventObject(
            dates: [DateInfo(startDate: "2025-09-15", endDate: nil, startTime: "20:00:00", endTime: nil, start: 1757955600, end: 1757955600)],
            title: "спектакль «Кровоизлияние в МОСХ» в театре «Практика»",
            place: Place(id: 1065, title: "Театр «Практика»", slug: "teatr-praktika", address: "Зубовский бул., д. 2, стр. 3", phone: "+7 495 640-65-64", isStub: false, siteURL: "https://kudago.com/msk/place/teatr-praktika/", coords: Coordinates(lat: 55.736976, lon: 37.593223)),
            description: "Режиссёр Юрий Печенежский дебютировал в «Практике».",
            bodyText: nil,
            images: nil,
            poster: nil,
            first_image: EventImage(image: "https://media.kudago.com/images/event/36/e5/36e5d01ab9bd130fc9a8816a84b0ce79.jpeg", thumbnails: nil)
        )
    )
    
    static let mockMovie = Event(
        dates: nil,
        title: nil,
        place: nil,
        description: nil,
        bodyText: nil,
        images: nil,
        poster: nil,
        publicationDate: nil,
        favoritesCount: nil,
        categories: nil,
        isFree: nil,
        datetime: 1757955600,
        movie: Movie(id: 3867, title: "Миллиард", description: nil, bodyText: nil, poster: EventImage(image: "https://media.kudago.com/images/movie/poster/f2/c2/f2c297b62c820a65ee04c34f100f82c3.jpg", thumbnails: nil)),
        object: nil
    )
}
extension Event {
    static let events: [Event] = [
        mockExhibition,
        mockConcert,
        mockMarathon,
        mockToday,
        mockMovie
    ]
}
