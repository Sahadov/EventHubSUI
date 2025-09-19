//
//  FilterViewModel.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 18/09/2025.
//
import SwiftUI

final class FilterViewModel: ObservableObject {
    @Published var preferences: SearchPreferences
    
    init() {
        self.preferences = SearchDataManager.shared.loadSearchPreferences()
        ?? SearchPreferences(
            selectedCategories: [],
            startDate: nil,
            endDate: nil,
            location: .spb,
            minPrice: 20,
            maxPrice: 120
        )
    }
    
    func reset() {
        preferences = SearchPreferences(
            selectedCategories: [],
            startDate: nil,
            endDate: nil,
            location: .spb,
            minPrice: 0,
            maxPrice: 200
        )
        print("RESET")
    }
    
    func apply() {
        SearchDataManager.shared.saveSearchPreferences(preferences)
        print("APPLY")
    }
}
