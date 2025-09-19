//
//  ExploreDetailView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreDetailView: View {
    var event: Event
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: screenWidth * 0.02) {
            
            Text(event.title?.capitalized ?? "No title")
                .font(.system(size: screenWidth * 0.039, weight: .semibold))
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundStyle(.black)
            
            HStack(spacing: screenWidth * 0.02) {
                iconView
                Text("+\(event.favoritesCount ?? 4) Going")
                    .foregroundColor(Color(hex: "#3F38DD"))
                    .font(.system(size: screenWidth * 0.035))
            }
            adressView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var iconView: some View {
        HStack(spacing: -screenWidth * 0.03) {
            Image(.friend3)
            Image(.friend2)
            Image(.friend1)
        }
    }
    
    var adressView: some View {
        HStack(spacing: screenWidth * 0.02) {
            Image(.mapPin)
//            Text(event.place?.address?.capitalized ?? "unknown")
            Text("36 Guild street London, UK")
                .foregroundColor(Color(hex: "#9593a4"))
//                .font(.system(size: screenWidth * 0.035, weight: .regular))
                .truncationMode(.tail)
                .lineLimit(1)
            
                .font(.Airbnb.light(size: screenWidth * 0.035))

//            screenWidth * 0.035
        }
    }
}


#Preview {
    ExploreDetailView(event: .mockConcert)
}

