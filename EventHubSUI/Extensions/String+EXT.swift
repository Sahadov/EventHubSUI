//
//  String+EXT.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 10/09/2025.
//

import Foundation

extension String {
    /// Преобразует строку вида "yyyy-MM-dd" в формат "EEE, MMM d •"
    func formattedAsEventDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE, MMM d •"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return outputFormatter.string(from: date)
    }
}
