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
    var onBookmarkTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            ImageLoaderView()
                .aspectRatio(0.8, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                HStack {
                    Text("Wed, Apr 8 5:30 PM")
                        .font(.Airbnb.book(size: 17))
                        .foregroundStyle(.accentBlue)
                    Spacer()
                    
                    if type == .favourites {
                        Button {
                            onBookmarkTapped?()
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .foregroundStyle(Color.accentRed)
                        }
                    }
                }
                
                Spacer()
                Text(event.title)
                    .font(.Airbnb.medium(size: 18))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                Spacer()
                if type == .events || type == .favourites  {
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
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 106, maxHeight: 106, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack(spacing: 16) {
            EventCard(event: Event.mockConcert)
            EventCard(type: .search, event: Event.mockConcert)
            EventCard(type: .favourites, event: Event.mockConcert)
        }
        .padding()
        .frame(maxWidth: 330)
    }
}
