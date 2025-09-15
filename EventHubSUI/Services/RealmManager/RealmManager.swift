//
//  RealmManager.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 13/09/2025.
//

import Foundation
import RealmSwift

protocol RealmManaging {
    func save<T: Object>(_ object: T)
    func save<T: Object>(_ objects: [T])
    func fetch<T: Object>(_ type: T.Type) -> Results<T>
    func delete<T: Object>(_ object: T)
    func deleteAll<T: Object>(_ type: T.Type)
    func exists<T: Object, KeyType>(type: T.Type, forPrimaryKey key: KeyType) -> Bool
}

final class RealmManager: RealmManaging {
    static let shared = RealmManager()
    private let realm: Realm
   
    private init() {
        // ⚡️ увеличивай номер версии при каждом изменении RealmEvent
        let config = Realm.Configuration(
            schemaVersion: 3, // увеличиваем на 1 от предыдущей версии
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Старые миграции для RealmEvent
                    migration.enumerateObjects(ofType: RealmEvent.className()) { _, newObject in
                        newObject?["poster"] = nil
                        newObject?["publicationDate"] = Date().timeIntervalSince1970
                    }
                }
                
                if oldSchemaVersion < 3 {
                    // Новые поля для RealmPlace
                    migration.enumerateObjects(ofType: RealmPlace.className()) { _, newObject in
                        newObject?["slug"] = nil
                        newObject?["phone"] = nil
                        newObject?["isStub"] = false
                        newObject?["siteURL"] = nil
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
        } catch {
            fatalError("DEBUG: Error initializing Realm: \(error)")
        }
    }
    
//    private init() {
//        do {
//            realm = try Realm()
//        } catch {
//            fatalError("DEBUG: Error initializing Realm: \(error)")
//        }
//    }
    
    // MARK: - Save
    
    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("DEBUG: Error saving object: \(error)")
        }
    }
    
    func save<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print("DEBUG: Error saving objects: \(error)")
        }
    }
    
    // MARK: - Fetch
    
    func fetch<T: Object>(_ type: T.Type) -> Results<T> {
        realm.objects(type)
    }
    
    // MARK: - Delete
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("DEBUG: Error deleting object: \(error)")
        }
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        let objects = realm.objects(type)
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print("DEBUG: Error deleting all objects of type \(T.self): \(error)")
        }
    }
    
    // MARK: - Exists
    
    func exists<T: Object, KeyType>(type: T.Type, forPrimaryKey key: KeyType) -> Bool {
        realm.object(ofType: type, forPrimaryKey: key) != nil
    }
}

extension RealmManager {
    func toggleEvent(_ event: Event) {
        let id = event.id
        if exists(type: RealmEvent.self, forPrimaryKey: id) {
            if let object = realm.object(ofType: RealmEvent.self, forPrimaryKey: id) {
                delete(object)
                print("DEBUG: Event removed from favorites")
            }
        } else {
            let realmEvent = RealmEvent(from: event)
            save(realmEvent)
            print("DEBUG: Event saved to favorites")
        }
    }
}

/*
let event = Event(...) // полученный из API

// Сохранить
RealmManager.shared.save(RealmEvent(from: event))

// Проверить наличие
if RealmManager.shared.exists(type: RealmEvent.self, forPrimaryKey: event.id) {
    print("Event есть в базе")
}

// Получить все
let allEvents = RealmManager.shared.fetch(RealmEvent.self)

// Toggle
RealmManager.shared.toggleEvent(event)
 
 */

