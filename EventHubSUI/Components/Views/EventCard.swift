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
    case isFavourite
}

struct EventCard: View {
    var type: ScreenType = .events
    var event: Event
    var isFavourite: Bool = false
    var onBookmarkTapped: (() -> Void)? = nil
    var onCardTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            ImageLoaderView(urlString: event.displayImageURL ?? "fff")
                .aspectRatio(0.9, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                HStack {
                    Text(event.formattedStartDate)
                        .font(.Airbnb.book(size: 17))
                        .foregroundStyle(.accentBlue)
                    Spacer()
                    
                    if type == .favourites {
                        Button {
                            onBookmarkTapped?()
                        } label: {
                            Image(systemName: isFavourite ? "bookmark.fill" : "bookmark")
                            .foregroundStyle(Color.accentRed)
                        }
                    }
                    
                    if type == .isFavourite {
                        Button {
                            onBookmarkTapped?()
                        } label: {
                            Image(systemName:"bookmark.fill")
                            .foregroundStyle(Color.accentRed)
                        }
                    }
                }
                
                Spacer()
                Text(event.displayTitle.capitalized)
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
                        Text(event.place?.address ?? "Уточните адрес")
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
        .onTapGesture {
            
                   onCardTapped?()
               }
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
