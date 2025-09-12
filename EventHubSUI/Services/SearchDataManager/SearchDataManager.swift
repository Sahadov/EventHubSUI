//
//  SearchDataManager.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 12/09/2025.
//
import SwiftUI

final class SearchDataManager {
    static let shared = SearchDataManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let searchPreferences = "searchPreferences"
        static let userLocation = "userLocation"
    }
    
    private init() {}
    
    // MARK: - Search Preferences
    func saveSearchPreferences(_ preferences: SearchPreferences) {
        if let data = try? JSONEncoder().encode(preferences) {
            defaults.set(data, forKey: Keys.searchPreferences)
        }
    }
    
    func loadSearchPreferences() -> SearchPreferences? {
        guard let data = defaults.data(forKey: Keys.searchPreferences) else { return nil }
        return try? JSONDecoder().decode(SearchPreferences.self, from: data)
    }
    
    func clearSearchPreferences() {
        defaults.removeObject(forKey: Keys.searchPreferences)
    }
    
    // MARK: - User Location
    func saveUserLocation(_ location: UserLocation) {
        if let data = try? JSONEncoder().encode(location) {
            defaults.set(data, forKey: Keys.userLocation)
        }
    }
    
    func loadUserLocation() -> UserLocation? {
        guard let data = defaults.data(forKey: Keys.userLocation) else { return nil }
        return try? JSONDecoder().decode(UserLocation.self, from: data)
    }
    
    func clearUserLocation() {
        defaults.removeObject(forKey: Keys.userLocation)
    }
}

/*
 
 // Сохраняем предпочтения
 let prefs = SearchPreferences(
     selectedCategory: "Concert",
     searchDate: Date(),
     searchLocation: "São Paulo",
     priceFrom: 50,
     priceTo: 200
 )

 SearchDataManager.shared.saveSearchPreferences(prefs)
 
 // Прочитать фильтр поиска
 if let savedPrefs = SearchDataManager.shared.loadSearchPreferences() {
     print("Category:", savedPrefs.selectedCategory ?? "-")
     print("Search location:", savedPrefs.searchLocation ?? "-")
 }
 
 // Очистить фильтр поиска
 SearchDataManager.shared.clearSearchPreferences()
 
 // Сохранить выбранную пользователем локацию
 let coord = CLLocationCoordinate2D(latitude: -23.55, longitude: -46.63)
 let userLoc = UserLocation(coordinate: coord)

 SearchDataManager.shared.saveUserLocation(userLoc)
 
 // Прочитать выбранную локацию
 if let savedLoc = SearchDataManager.shared.loadUserLocation() {
     print("User selected lat:", savedLoc.latitude, "lon:", savedLoc.longitude)
 }
 
 // Очистить локацию
 SearchDataManager.shared.clearUserLocation()
 

*/
