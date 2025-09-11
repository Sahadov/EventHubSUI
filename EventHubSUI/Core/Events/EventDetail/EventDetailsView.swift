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
                        Text(event.title ?? "No title")
                            .font(.Airbnb.book(size: 35))
                        VStack(alignment: .leading, spacing: 24) {
                            VStack(alignment: .leading, spacing: 16) {
                                EventInfoView(
                                    firstText: event.dates?.first?.startDate?.formattedAsEventDate() ?? "No date",
                                    secondText:
                                        "\(String(event.dates?.first?.startTime?.prefix(5) ?? "No time")) - \(String(event.dates?.first?.endTime?.prefix(5) ?? "No time"))",
                                    iconName: "blueCalendar"
                                )
                                EventInfoView(
                                    firstText: event.place?.title ?? "No place",
                                    secondText: event.place?.address ?? "No adress",
                                    iconName: "bluePin"
                                )
                            }
                            EventInfoView(
                                firstText: "Organizer name",
                                secondText: "Organizer",
                                iconName: "map-pin"
                            )
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
                .font(.Airbnb.book(size: 16))
        }
    }
}

#Preview {
    EventDetailsView(event: Event.mockConcert)
}
