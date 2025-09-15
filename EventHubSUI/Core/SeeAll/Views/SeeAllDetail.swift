//
//  SeeAllDetail.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

import SwiftUI

struct SeeAllDetail: View {
    let event: Event
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: - Дата события
            if !event.formattedStartDate.isEmpty {
                Text(event.formattedStartDate)
                    .font(.system(size: screenWidth * 0.035, weight: .light))
                    .foregroundStyle(.accentBlue)
            } else {
                HStack(spacing: 4) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .foregroundStyle(.gray)
                    Text("No date available")
                        .font(.system(size: screenWidth * 0.035, weight: .light))
                        .foregroundStyle(.gray)
                }
            }
            
            // Название события
            Text(event.displayTitle)
                .font(.system(size: screenWidth * 0.045, weight: .regular))
                .lineLimit(2)
            
            // Локация
            HStack {
                if let place = event.place ?? event.object?.place, let address = place.address, !address.isEmpty {
                    Image(systemName: "mappin")
                    Text(address)
                        .font(.system(size: screenWidth * 0.035, weight: .regular))
                        .foregroundStyle(.gray)
                } else {
                    Image(systemName: "mappin.slash")
                    Text("No location")
                        .font(.system(size: screenWidth * 0.035, weight: .regular))
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SeeAllDetail(event: Event.mockConcert) // обычное событие
    SeeAllDetail(event: Event.mockToday)   // твой мок today
}

