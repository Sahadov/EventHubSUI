//
//  NotificationItem.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 22.09.2025.
//

import Foundation

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let time: String
}
