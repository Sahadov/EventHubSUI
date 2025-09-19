//
//  LocationButtonView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct LocationButtonView: View {
    var city: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text("Current Location")
                    .font(.system(size: 12, weight: .light))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Image(.downArrow)
                    .resizable()
                    .frame(width: 12, height: 12)
            }
            
            Text(city)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
    }
}

#Preview {
    LocationButtonView(city: "Moscow")
        .background(Color.gray)
}
