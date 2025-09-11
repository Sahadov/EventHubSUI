//
//  Endpoint.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import Foundation

enum Endpoint {
    /// Получение предстоящих событий (Upcoming events)  cортировка по дате добавления/начала события
    /// - Parameters:
    ///   - lon: Долгота (по умолчанию Москва: 55.7569)
    ///   - lat: Широта (по умолчанию Москва: 37.6151)
    ///   - radius: Радиус поиска вокруг координат (метры, по умолчанию 5000)
    ///     - Примечание: этот параметр передается в queryItems как URLQueryItem(name: "radius", value: "5000")
    case getUpcomingEvents(_ lon: Double = 55.7569, _ lat: Double = 37.6151)
    /// Получение событий рядом с указанными координатами (Nearby events) cортировка по расстоянию от точки
    case getNearbyEvents(lon: Double = 55.7569, lat: Double = 37.6151)
    /// Получение прошедших событий (Past events)
    /// Сортировка: по дате события в обратном порядке (сначала недавние прошедшие события)
    ///   - number: Количество событий для загрузки (по умолчанию 20)
    ///     - Примечание: используются параметры `actual_until` (до текущей даты) и `ordering=-dates`
    case getPastEvents(lon: Double = 55.7569, lat: Double = 37.6151, number: Int = 20)
    /// Получение событий по категории
    /// Сортировка: по дате события (от актуальных)
    /// - Parameters:
    ///   - category: Категория события (например, concerts, theatre, exhibitions и т.д.)
    case getEventsBy(category: EventCategory)
    
    var baseURL: String { "https://kudago.com" }
    
    var path: String { "/public-api/v1.4/events/" }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.append(contentsOf: [
           URLQueryItem(name: "fields", value: "dates,title,place,description,body_text,images,favorites_count"),
           URLQueryItem(name: "number", value: "100"),
           URLQueryItem(name: "text_format", value: "text"),
           URLQueryItem(name: "expand", value: "place,dates,images")
        ])

        
        switch self {
        case .getUpcomingEvents(let lat, let lon):
            items.append(URLQueryItem(name: "actual_since", value: String(Int(Date().timeIntervalSince1970))))
            items.append(URLQueryItem(name: "lat", value: String(lat)))
            items.append(URLQueryItem(name: "lon", value: String(lon)))
            items.append(URLQueryItem(name: "radius", value: "10000"))
            
        case .getNearbyEvents(let lat, let lon):
            items.append(URLQueryItem(name: "radius", value: "5000"))
            items.append(URLQueryItem(name: "lat", value: String(lat)))
            items.append(URLQueryItem(name: "lon", value: String(lon)))
            
        case .getPastEvents(let lat, let lon, let number):
            items.append(URLQueryItem(name: "actual_until", value: String(Int(Date().timeIntervalSince1970))))
            items.append(URLQueryItem(name: "ordering", value: "-dates"))
            items.append(URLQueryItem(name: "lat", value: String(lat)))
            items.append(URLQueryItem(name: "lon", value: String(lon)))
            items.append(URLQueryItem(name: "radius", value: "5000"))
            items.append(URLQueryItem(name: "number", value: String(number)))
            
        case .getEventsBy(let category):
            items.append(URLQueryItem(name: "categories", value: category.rawValue))
            items.append(URLQueryItem(name: "actual_since", value: String(Int(Date().timeIntervalSince1970))))
        }
        
        return items
    }
}
