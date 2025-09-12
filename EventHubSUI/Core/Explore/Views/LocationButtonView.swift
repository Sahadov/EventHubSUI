//
//  LocationButtonView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct LocationButtonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text("Current Location")
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Image(.downArrow)
                    .resizable()
                    .frame(width: 12, height: 12)
            }
            
            Text("New York, USA")
                .font(.system(size: 12))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
    }
}

#Preview {
    LocationButtonView()
        .background(Color.gray)
}
