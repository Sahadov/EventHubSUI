//
//  EventDetailsView.swift
//  EventHubSUI
//
//  Created by Элина Борисова on 10.09.2025.
//

import SwiftUI

struct EventDetailsView: View {
    var event: Event
    @State private var showShareSheet = false
    @State private var isBookmarked: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            
            EventDetailTopView(
                event: event,
                isBookmarked: $isBookmarked,
                onShareTapped: {
                    showShareSheet.toggle()
                }
            )

            
            Text(event.displayTitle.uppercased())
                .font(.Airbnb.book(size: 30))
                .lineLimit(3)
                .minimumScaleFactor(0.5)
                .allowsTightening(true)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .leading) 
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

            VStack(alignment: .leading) {
                EventInfoView(firstText: event.formattedCalendarDate,
                              secondText: event.formattedStartDate,
                              iconName: "blueCalendar")
                
                EventInfoView(firstText: event.place?.title ?? "Unknown place",
                              secondText: event.formattedStartDate,
                              iconName: "bluePin")
                
                EventInfoView(firstText: "Unknown",
                              secondText: "Organizer",
                              iconName: "Organizer")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            AboutView(event: event)
        }
        .onAppear {
            // Устанавливаем начальное состояние кнопки закладки
            isBookmarked = RealmManager.shared.exists(type: RealmEvent.self, forPrimaryKey: event.id)
        }
        .searchNavigationStyle(title: "Event Detail",
                               itemColor: .white,
                               dismissAction: { dismiss() })
        .ignoresSafeArea()
        .sheet(isPresented: $showShareSheet) {
            ShareBottomSheet()
                .presentationDetents([.height(359)])
                .presentationCornerRadius(38)
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - About
struct AboutView: View {
    var event: Event
    var body: some View {
        Text("About Event")
            .font(.system(size: 18))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        Text(event.bodyText ?? "No description")
            .font(.Airbnb.book(size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

#Preview {
    EventDetailsView(event: Event.mockExhibition)
}

