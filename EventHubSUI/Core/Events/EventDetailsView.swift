//
//  EventDetailsView.swift
//  EventHubSUI
//
//  Created by Элина Борисова on 10.09.2025.
//

import SwiftUI

struct EventDetailsView: View {
    var event: Event
    var body: some View {
        VStack(spacing: 50) {
            AsyncImage(url: URL(string: event.images?.first?.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 244)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 244)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 244)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                @unknown default:
                    EmptyView()
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 21) {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(event.title ?? "")
                            .font(.system(size: 35))
                        VStack(alignment: .leading, spacing: 24) {
                            VStack(alignment: .leading, spacing: 16) {
                                ConcertDatePlaceView(
                                    firstText: event.dates?.first?.startDate ?? "No date",
                                    secondText: event.dates?.first?.startTime ?? "No time",
                                    iconName: "blueCalendar"
                                )
                                ConcertDatePlaceView(
                                    firstText: event.place?.title ?? "No place",
                                    secondText: event.place?.address ?? "No adress",
                                    iconName: "bluePin"
                                )
                            }
                            ConcertDatePlaceView(
                                firstText: "Organizer name",
                                secondText: "Organizer", iconName: "bluePin")
                        }
                    }
                    aboutEvent
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    private var aboutEvent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About Event")
                .font(.system(size: 18))
            Text(event.bodyText ?? "No description")
                .font(.system(size: 16))
        }
    }
}

struct ConcertDatePlaceView: View {
    let firstText: String
    let secondText: String
    let iconName: String
    
    init(firstText: String, secondText: String, iconName: String) {
        self.firstText = firstText
        self.secondText = secondText
        self.iconName = iconName
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Image(iconName)
                Rectangle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.accentBlue.opacity(0.1))
                    .cornerRadius(12)
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(firstText)
                    .font(.system(size: 16))
                    .frame(height: 34)
                Text(secondText)
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    EventDetailsView(event: Event.mockConcert)
}
