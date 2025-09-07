//
//  EventsView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        VStack {
            Text("EVENTS")
                .foregroundStyle(.accentRed)
                .font(.Airbnb.light(size: 20))
            ImageLoaderView()
                .frame(width: 100, height: 100)
        }
        
    }
}

#Preview {
    EventsView()
}
