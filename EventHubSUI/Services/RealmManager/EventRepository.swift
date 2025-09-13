//
//  EventRepository.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 13/09/2025.
//

import RealmSwift

protocol EventRepositoryProtocol {
    func getFavorites() -> [Event]
    func isFavorite(event: Event) -> Bool
    func saveToFavorites(event: Event)
    func removeFromFavorites(event: Event)
    func toggleFavorite(event: Event)
}

final class EventRepository: EventRepositoryProtocol {
    private let realmManager = RealmManager.shared
    
    // MARK: - Get
    
    func getFavorites() -> [Event] {
        let results = realmManager.fetch(RealmEvent.self)
        return results.map { $0.toEvent() } // нужен маппинг обратно в Event
    }
    
    // MARK: - Check
    
    func isFavorite(event: Event) -> Bool {
        realmManager.exists(type: RealmEvent.self, forPrimaryKey: event.id)
    }
    
    // MARK: - Save
    
    func saveToFavorites(event: Event) {
        let realmEvent = RealmEvent(from: event)
        realmManager.save(realmEvent)
    }
    
    // MARK: - Remove
    
    func removeFromFavorites(event: Event) {
        if let object = realmManager.fetch(RealmEvent.self)
            .filter("id == %@", event.id).first {
            realmManager.delete(object)
        }
    }
    
    // MARK: - Toggle
    
    func toggleFavorite(event: Event) {
        if isFavorite(event: event) {
            removeFromFavorites(event: event)
        } else {
            saveToFavorites(event: event)
        }
    }
}

/*
 
 let repo = EventRepository()
 let event = Event(...) // получен из API

 // Добавить в избранное
 repo.saveToFavorites(event: event)

 // Проверить
 if repo.isFavorite(event: event) {
     print("В избранном")
 }

 // Убрать
 repo.removeFromFavorites(event: event)

 // Toggle
 repo.toggleFavorite(event: event)

 // Все избранные
 let favorites = repo.getFavorites()
 print("Saved favorites:", favorites.count)
 
 */

