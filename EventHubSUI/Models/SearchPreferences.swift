//
//  SearchPreferences.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 12/09/2025.
//

import Foundation

struct SearchPreferences: Codable {
    var selectedCategory: String
    var searchDate: Date
    var searchLocation: String
    var priceFrom: Double
    var priceTo: Double
}


