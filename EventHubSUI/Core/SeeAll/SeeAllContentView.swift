//
//  SeeAllContentView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct SeeAllContentView: View {
    var event: [Event]
    
    var body: some View {
        ScrollView {
            ForEach(event, id: \.id) { event in
                SeeAllCell(event: event)
            }
        }
    }
}

#Preview {
    SeeAllContentView(event: Event.events)
}
