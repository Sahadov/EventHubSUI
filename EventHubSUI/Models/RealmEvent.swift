//
//  RealmEvent.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 13/09/2025.
//

import RealmSwift
import CoreLocation

class RealmEvent: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String? = nil
    @objc dynamic var eventDescription: String? = nil
    @objc dynamic var bodyText: String? = nil
    let images = List<RealmEventImage>()
    let dates = List<RealmDateInfo>()
    @objc dynamic var place: RealmPlace? = nil
    let categories = List<String>()
    @objc dynamic var favoritesCount: Int = 0
    @objc dynamic var isFree: Bool = false
    
    override static func primaryKey() -> String? {
        "id"
    }
}

class RealmDateInfo: Object {
    @objc dynamic var startDate: String? = nil
    @objc dynamic var endDate: String? = nil
    @objc dynamic var startTime: String? = nil
    @objc dynamic var endTime: String? = nil
    @objc dynamic var start: Double = 0
    @objc dynamic var end: Double = 0
}

class RealmPlace: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
    @objc dynamic var address: String? = nil
    @objc dynamic var coords: RealmCoordinates? = nil
    @objc dynamic var subway: String? = nil
}

class RealmEventImage: Object {
    @objc dynamic var image: String? = nil
    @objc dynamic var thumbnails: RealmThumbnails? = nil
}

class RealmThumbnails: Object {
    @objc dynamic var size640x384: String? = nil
    @objc dynamic var size144x96: String? = nil
}

class RealmCoordinates: Object {
    @objc dynamic var lat: Double = 0
    @objc dynamic var lon: Double = 0
}


extension RealmEvent {
    convenience init(from event: Event) {
        self.init()
        self.id = event.id
        self.title = event.title
        self.eventDescription = event.description
        self.bodyText = event.bodyText
        self.favoritesCount = event.favoritesCount ?? 0
        self.isFree = event.isFree ?? false
        
        if let categories = event.categories {
            self.categories.append(objectsIn: categories)
        }
        
        if let dates = event.dates {
            let realmDates = dates.map { RealmDateInfo(from: $0) }
            self.dates.append(objectsIn: realmDates)
        }
        
        if let place = event.place {
            self.place = RealmPlace(from: place)
        }
        
        if let images = event.images {
            let realmImages = images.map { RealmEventImage(from: $0) }
            self.images.append(objectsIn: realmImages)
        }
    }
}

extension RealmDateInfo {
    convenience init(from dateInfo: DateInfo) {
        self.init()
        self.startDate = dateInfo.startDate
        self.endDate = dateInfo.endDate
        self.startTime = dateInfo.startTime
        self.endTime = dateInfo.endTime
        self.start = dateInfo.start ?? 0
        self.end = dateInfo.end ?? 0
    }
}

extension RealmPlace {
    convenience init(from place: Place) {
        self.init()
        self.id = place.id ?? 0
        self.title = place.title
        self.address = place.address
        self.subway = place.subway
        if let coords = place.coords {
            self.coords = RealmCoordinates(from: coords)
        }
    }
}

extension RealmCoordinates {
    convenience init(from coords: Coordinates) {
        self.init()
        self.lat = coords.lat ?? 0
        self.lon = coords.lon ?? 0
    }
}

extension RealmEventImage {
    convenience init(from image: EventImage) {
        self.init()
        self.image = image.image
        if let thumbnails = image.thumbnails {
            self.thumbnails = RealmThumbnails(from: thumbnails)
        }
    }
}

extension RealmThumbnails {
    convenience init(from thumbnails: EventImage.Thumbnails) {
        self.init()
        self.size640x384 = thumbnails.size640x384
        self.size144x96 = thumbnails.size144x96
    }
}

// Маппинг обратно (RealmEvent в Event)
extension RealmEvent {
    func toEvent() -> Event {
        return Event(
            dates: dates.map { $0.toDateInfo() },
            title: title,
            place: place?.toPlace(),
            description: eventDescription,
            bodyText: bodyText,
            images: images.map { $0.toEventImage() },
            favoritesCount: favoritesCount,
            categories: Array(categories),
            isFree: isFree
        )
    }
}

extension RealmDateInfo {
    func toDateInfo() -> DateInfo {
        return DateInfo(
            startDate: startDate,
            endDate: endDate,
            startTime: startTime,
            endTime: endTime,
            start: start == 0 ? nil : start,
            end: end == 0 ? nil : end
        )
    }
}

extension RealmPlace {
    func toPlace() -> Place {
        return Place(
            id: id,
            title: title,
            address: address,
            coords: coords?.toCoordinates(),
            subway: subway
        )
    }
}

extension RealmCoordinates {
    func toCoordinates() -> Coordinates {
        return Coordinates(
            lat: lat,
            lon: lon
        )
    }
}

extension RealmEventImage {
    func toEventImage() -> EventImage {
        return EventImage(
            image: image,
            thumbnails: thumbnails?.toThumbnails()
        )
    }
}

extension RealmThumbnails {
    func toThumbnails() -> EventImage.Thumbnails {
        return EventImage.Thumbnails(
            size640x384: size640x384,
            size144x96: size144x96
        )
    }
}
