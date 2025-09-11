//
//  ExploreDetailView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreDetailView: View {
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: screenWidth * 0.02) {
            
            Text("International Band Music Concert")
                .font(.system(size: screenWidth * 0.045, weight: .semibold))
                .lineLimit(1)
                .truncationMode(.tail)
            
            HStack(spacing: screenWidth * 0.02) {
                iconView
                Text("+20 Going")
                    .foregroundColor(Color(hex: "#3F38DD"))
                
                    .font(.system(size: screenWidth * 0.035))
            }
            
            // Адрес
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
            Text("36 Guild Street London, UK")
                .foregroundColor(Color(hex: "#2B2849"))
                .font(.system(size: screenWidth * 0.035))
        }
    }
}


#Preview {
    ExploreDetailView()
}

