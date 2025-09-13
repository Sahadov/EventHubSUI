//
//  ExploreCell.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreCell: View {
    let event: Event
    let isPlaceholder: Bool
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        let cardWidth = screenWidth * 0.7
        let imageHeight = cardWidth * 0.72
        
        VStack(spacing: 0) {
            if isPlaceholder {
                placeholderImage
                    .frame(width: cardWidth, height: imageHeight)
                    .padding()
                
                placeholderDetails
                    .padding()
                    .frame(width: cardWidth, alignment: .leading)
            } else {
                ExploreImageView(event: event)
                    .frame(width: cardWidth, height: imageHeight)
                    .padding()
                
                ExploreDetailView(event: event)
                    .padding()
                    .frame(width: cardWidth, alignment: .leading)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: screenWidth * 0.03)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.vertical, screenWidth * 0.02)
    }
    
    // MARK: - Skeleton Views
    var placeholderImage: some View {
        RoundedRectangle(cornerRadius: screenWidth * 0.03)
            .fill(Color.gray.opacity(0.3))
            .shimmering()
    }
    
    var placeholderDetails: some View {
        VStack(alignment: .leading, spacing: screenWidth * 0.02) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 16)
                .shimmering()
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 12)
                .shimmering()
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 12)
                .shimmering()
        }
    }
}



#Preview {
    ExploreCell(event: .mockConcert, isPlaceholder: true)
}

