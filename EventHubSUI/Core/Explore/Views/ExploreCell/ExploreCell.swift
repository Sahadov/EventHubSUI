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
    
    var onBookmarkTap: (() -> Void)?
    
    var body: some View {
        let cardWidth = screenWidth * 0.55
        let imageHeight = cardWidth * 0.45
        
        VStack(spacing: 0) {
            if isPlaceholder {
                placeholderImage
                    .frame(width: cardWidth, height: imageHeight)
                    .padding()
                  
                placeholderDetails
                    .padding(.horizontal)
                    .frame(width: cardWidth, alignment: .leading)
            } else {
                ExploreImageView(event: event, onBookmarkTapped: onBookmarkTap)
                    .frame(width: cardWidth, height: imageHeight)
                    .padding(10)
                    .padding(.top, 20)
                
                ExploreDetailView(event: event)
                    .padding(.vertical, 25)
                    
                    .frame(width: cardWidth, alignment: .leading)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: screenWidth * 0.03)
                .fill(Color(hex: "#ffffff"))
        )
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)  убрал тень, как в figma 
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
            RoundedRectangle(cornerRadius: screenWidth * 0.015)
                .fill(Color.gray.opacity(0.2))
                .frame(height: screenWidth * 0.035) 
                .shimmering()
            
            RoundedRectangle(cornerRadius: screenWidth * 0.015)
                .fill(Color.gray.opacity(0.2))
                .frame(height: screenWidth * 0.03)
                .shimmering()
            
            RoundedRectangle(cornerRadius: screenWidth * 0.015)
                .fill(Color.gray.opacity(0.2))
                .frame(width: screenWidth * 0.25, height: screenWidth * 0.03)
                .shimmering()
        }
        .padding(.horizontal, screenWidth * 0.02)
        .padding(.vertical, screenWidth * 0.09)
    }

}



#Preview {
    ExploreCell(event: .mockConcert, isPlaceholder: true)
}

