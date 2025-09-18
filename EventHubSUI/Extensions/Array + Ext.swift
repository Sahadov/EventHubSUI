//
//  Array + Ext.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 14.09.2025.
//

import Foundation

extension Array where Element == Event {
    /// Убирает дубликаты по уникальному ключу title+place+startDate
    func removingDuplicates() -> [Event] {
        var seen = Set<String>()
        return self.filter { event in
            let key = [
                event.title ?? "",
                event.place?.id.map(String.init) ?? "",
                event.nextDate?.startDate ?? ""
            ].joined(separator: "|")
            if seen.contains(key) {
                return false
            } else {
                seen.insert(key)
                return true
            }
        }
    }
    
    /// Сортировка по возрастанию даты
    func sortedByDate() -> [Event] {
        sorted { a, b in
            switch (a.displayDate, b.displayDate) {
            case let (la?, lb?): return la < lb
            case (nil,  _?):     return false
            case (_?,   nil):    return true
            case (nil, nil):     return false
            }
        }
    }
    
    func uniqueSortedByDate() -> [Event] {
        removingDuplicates().sortedByDate()
    }
}
