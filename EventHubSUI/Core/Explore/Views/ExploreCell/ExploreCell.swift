//
//  ExploreCell.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreCell: View {
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        let cardWidth = screenWidth * 0.7
        let imageHeight = cardWidth * 0.72
        
        VStack(spacing: 0) {
            ExploreImageView()
                .frame(width: cardWidth, height: imageHeight)
                .padding()
            
            ExploreDetailView()
                .padding()
                .frame(width: cardWidth, alignment: .leading)
            
        }
        .background(
            RoundedRectangle(cornerRadius: screenWidth * 0.03)
                .fill(Color.white)
            
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.vertical, screenWidth * 0.02)
    }
}

#Preview {
    ExploreCell()
}

