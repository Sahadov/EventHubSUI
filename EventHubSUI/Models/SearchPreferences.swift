//
//  SearchPreferences.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 12/09/2025.
//

import Foundation

struct SearchPreferences: Codable {
    var selectedCategories: [String] = []
    var startDate: Date? = nil
    var endDate: Date? = nil
    var location: LocationsList = .msk
    var minPrice: Double? = nil
    var maxPrice: Double? = nil
}


