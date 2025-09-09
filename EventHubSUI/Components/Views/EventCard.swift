//
//  EventCard.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 08/09/2025.
//

import SwiftUI

enum ScreenType {
    case events
    case favourites
    case search
}

struct EventCard: View {
    var type: ScreenType = .events
    var event: Event
    
    var body: some View {
        HStack(spacing: 15) {
            ImageLoaderView()
                .aspectRatio(0.8, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text("Wed, Apr 8 5:30 PM")
                    .font(.Airbnb.book(size: 17))
                    .foregroundStyle(.accentBlue)
                Spacer()
                Text(event.title)
                    .font(.Airbnb.medium(size: 18))
                Spacer()
                HStack {
                    Image("map-pin")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("Lot 13 Oakland, CA")
                        .font(.Airbnb.book(size: 17))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        EventCard(event: Event.mockConcert)
            .frame(width: 900, height: 106)
    }
}
