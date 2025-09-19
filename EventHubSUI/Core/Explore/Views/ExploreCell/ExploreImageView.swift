//
//  ExploreImageView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreImageView: View {
    let event: Event
    let screenWidth = UIScreen.main.bounds.width
    
    var onBookmarkTapped: (() -> Void)? = nil
    
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?w=144" ?? "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?w=144")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Image(.mockEvent)
                    .resizable()
                    .scaledToFill()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: screenWidth * 0.55, height: screenWidth * 0.49 * 0.72)
        .clipped()
        .cornerRadius(screenWidth * 0.03)
        .overlay(
            ZStack {
                dateView
                    .padding(.top, screenWidth * 0.02)
                    .padding(.leading, screenWidth * 0.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                bookmarkView
                    .padding(.top, screenWidth * 0.02)
                    .padding(.trailing, screenWidth * 0.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
        )
    }
    
    // MARK: - Date View
    var dateView: some View {
        VStack(spacing: screenWidth * 0.01) {
            if event.isEndless {
                Image(systemName: "infinity")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: screenWidth * 0.04, height: screenWidth * 0.04)
            } else if let nextDate = event.nextDate {
                Text(nextDate.day)
                    .font(.system(size: screenWidth * 0.03, weight: .light, design: .default))
                    .foregroundColor(.red)
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                    .scaleEffect(x: 0.7, y: 1.3, anchor: .center)
                    
                Text(nextDate.month)
                    .font(.system(size: screenWidth * 0.013, weight: .bold, design: .monospaced))
                    .foregroundColor(.red)
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                    .scaleEffect(x: 1, y: 1.6, anchor: .center)
            } else {
                Image(systemName: "calendar.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: screenWidth * 0.04, height: screenWidth * 0.04)
            }
        }
        .frame(width: screenWidth * 0.111, height: screenWidth * 0.111)
        .background(
            RoundedRectangle(cornerRadius: screenWidth * 0.02)
                .fill(Color.white.opacity(0.8))
        )
    }
    
    // MARK: - Bookmark View
    var bookmarkView: some View {
        Button {
            isBookmarked.toggle()
            onBookmarkTapped?()
        } label: {
            Image(isBookmarked ? "bookmark2" : "bookmark")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.04, height: screenWidth * 0.04)
                .padding(screenWidth * 0.019)
                .background(
                    RoundedRectangle(cornerRadius: screenWidth * 0.014)
                        .fill(Color.white.opacity(0.8))
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ExploreImageView(event: .mockMarathon)
}
