//
//  Event.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import Foundation

struct Event: Codable {
    let id: Int?
    let title: String
    let slug: String
    let place: Place
    let description: String
    let bodyText: String
    let location: Location
    let categories: [String]
    let tagline: String?
    let ageRestriction: String
    let price: String
    let isFree: Bool
    let images: [EventImage]
    let favoritesCount: Int
    let commentsCount: Int
    let siteURL: URL
    let shortTitle: String

    enum CodingKeys: String, CodingKey {
        case title, slug, place, description, id
        case bodyText = "body_text"
        case location, categories, tagline
        case ageRestriction = "age_restriction"
        case price, isFree = "is_free", images
        case favoritesCount = "favorites_count"
        case commentsCount = "comments_count"
        case siteURL = "site_url"
        case shortTitle = "short_title"
    }
}

struct Place: Codable {
    let id: Int
}

struct Location: Codable {
    let slug: String
}

struct EventImage: Codable {
    let image: URL
    let source: ImageSource
}

struct ImageSource: Codable {
    let name: String?
    let link: String?
}


// MOCK DATA

extension Event {
    static let mockConcert = Event(
        id: 1,
        title: "Rock Festival 2025",
        slug: "rock-festival-2025",
        place: Place(id: 101),
        description: "Annual open-air rock music festival.",
        bodyText: "Join thousands of fans for an unforgettable weekend of live performances by the biggest names in rock music.",
        location: Location(slug: "moscow"),
        categories: ["music", "festival"],
        tagline: "Feel the music!",
        ageRestriction: "18+",
        price: "2500 RUB",
        isFree: false,
        images: [
            EventImage(
                image: URL(string: "https://picsum.photos/600/400?1")!,
                source: ImageSource(name: "Festival Photographer", link: "https://example.com")
            )
        ],
        favoritesCount: 340,
        commentsCount: 72,
        siteURL: URL(string: "https://rockfest.example.com")!,
        shortTitle: "Rock Fest"
    )

    static let mockExhibition = Event(
        id: 1,
        title: "Impressionist Art Exhibition",
        slug: "impressionist-art-exhibition",
        place: Place(id: 202),
        description: "A collection of impressionist paintings from the late 19th century.",
        bodyText: "The exhibition brings together masterpieces from Monet, Renoir, and Degas, providing a unique opportunity to see them in one place.",
        location: Location(slug: "saint-petersburg"),
        categories: ["art", "exhibition"],
        tagline: "Masterpieces in one hall",
        ageRestriction: "0+",
        price: "500 RUB",
        isFree: false,
        images: [
            EventImage(
                image: URL(string: "https://picsum.photos/600/400?2")!,
                source: ImageSource(name: "Art Gallery", link: nil)
            )
        ],
        favoritesCount: 120,
        commentsCount: 15,
        siteURL: URL(string: "https://artmuseum.example.com/exhibition")!,
        shortTitle: "Impressionists"
    )

    static let mockMarathon = Event(
        id: 1,
        title: "City Marathon",
        slug: "city-marathon-2025",
        place: Place(id: 303),
        description: "Annual city marathon open to runners of all levels.",
        bodyText: "Run through the heart of the city, enjoy the cheering crowds and beautiful views. Includes 5k, 10k, half, and full marathon.",
        location: Location(slug: "kazan"),
        categories: ["sport", "running"],
        tagline: "Run together!",
        ageRestriction: "12+",
        price: "Free",
        isFree: true,
        images: [
            EventImage(
                image: URL(string: "https://picsum.photos/600/400?3")!,
                source: ImageSource(name: nil, link: nil)
            )
        ],
        favoritesCount: 540,
        commentsCount: 98,
        siteURL: URL(string: "https://citymarathon.example.com")!,
        shortTitle: "Marathon"
    )
}

