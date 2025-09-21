//
//  Endpoint.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import Foundation

enum Endpoint {
    /// Upcoming events - sorted by date
    case getUpcomingEvents(_ location: LocationsList = .msk)
    /// Nearby events - sorted by distance
    case getNearbyEvents(_ location: LocationsList = .msk)
    /// Past events - sorted by date (reverse order)
    case getPastEvents(_ location: LocationsList = .msk)
    /// Events by category - sorted by publication date
    case getEventsBy(_ category: EventCategory, _ location: LocationsList = .msk)
    /// Events by location - sorted by date
    case getEventBy(_ location: LocationsList = .msk)
    
    /// Today's events
    case getTodayEvents(_ location: LocationsList = .msk)
    /// Movie screenings
    case getMovies(_ location: LocationsList = .msk)
    
    /// Movie screenings
    case getEventsWith(_ preferences: SearchPreferences)
    
    var baseURL: String { "https://kudago.com" }
    
    var path: String {
        switch self {
        case .getUpcomingEvents, .getNearbyEvents, .getPastEvents, .getEventsBy, .getEventBy, .getEventsWith:
            "/public-api/v1.4/events/"
        case .getTodayEvents:
            "/public-api/v1.4/events-of-the-day/"
        case .getMovies:
            "/public-api/v1.4/movie-showings/"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "text_format", value: "text")
        ]
        
        let now = Int(Date().timeIntervalSince1970)
        let commonFields = "dates,title,place,description,body_text,images,favorites_count,categories,slug,price,is_free"
        let commonExpand = "place,dates,images,categories,slug,price,is_free"
        
        switch self {
        case .getUpcomingEvents(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: "site_url,\(commonFields)"),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "location", value: location.rawValue),
                URLQueryItem(name: "order_by", value: "dates"),
                URLQueryItem(name: "actual_since", value: "\(now)")
            ])
            
        case .getNearbyEvents(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: commonFields),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "lat", value: String(location.latitude)),
                URLQueryItem(name: "lon", value: String(location.longitude)),
                URLQueryItem(name: "radius", value: "5000"),
                URLQueryItem(name: "order_by", value: "dates"),
                URLQueryItem(name: "actual_since", value: "\(now)")
            ])
            
        case .getPastEvents(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: commonFields),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "actual_until", value: "\(now)"),
                URLQueryItem(name: "order_by", value: "-publication_date"),
                URLQueryItem(name: "location", value: location.rawValue)
            ])
            
        case .getEventsBy(let category, let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: commonFields),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "location", value: location.rawValue),
                URLQueryItem(name: "categories", value: category.rawValue),
                URLQueryItem(name: "order_by", value: "-publication_date")
            ])
            
        case .getEventBy(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: commonFields),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "location", value: location.rawValue),
                URLQueryItem(name: "order_by", value: "dates"),
                URLQueryItem(name: "actual_since", value: "\(now)")
            ])
            
        case .getTodayEvents(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: "object,title,location,date"),
                URLQueryItem(name: "expand", value: "object,location,place"),
                URLQueryItem(name: "location", value: location.rawValue)
            ])
            
        case .getMovies(let location):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: "id,place,datetime,movie"),
                URLQueryItem(name: "expand", value: "movie,place,datetime"),
                URLQueryItem(name: "location", value: location.rawValue)
            ])
            
        case .getEventsWith(let preferences):
            items.append(contentsOf: [
                URLQueryItem(name: "fields", value: commonFields),
                URLQueryItem(name: "expand", value: commonExpand),
                URLQueryItem(name: "location", value: preferences.location.rawValue)
            ])
            
            if !preferences.selectedCategories.isEmpty {
                let cats = preferences.selectedCategories.joined(separator: ",")
                items.append(URLQueryItem(name: "categories", value: cats))
            }
            
//            if let minPrice = preferences.minPrice {
//                items.append(URLQueryItem(name: "price_from", value: "\(Int(minPrice))"))
//            }
//            if let maxPrice = preferences.maxPrice {
//                items.append(URLQueryItem(name: "price_to", value: "\(Int(maxPrice))"))
//            }
            
            if let startDate = preferences.startDate {
                let ts = Int(startDate.timeIntervalSince1970)
                items.append(URLQueryItem(name: "actual_since", value: "\(ts)"))
            }
            
            if let endDate = preferences.endDate {
                let ts = Int(endDate.timeIntervalSince1970)
                items.append(URLQueryItem(name: "actual_until", value: "\(ts)"))
            }
            
        }
        
        return items
    }
}
