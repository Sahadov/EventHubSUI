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
    
    var body: some View {
//        ImageLoaderView(
//            urlString: event.images?.first?.thumbnails?.size144x96 ?? "https://picsum.photos/640/384?2",
//            resizingMode: .fill
//        )
//        Image(.mockEvent)
//        .resizable()
//        .scaledToFill()
        AsyncImage(url: URL(string: event.images?.first?.thumbnails?.size144x96 ?? "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?w=144")) { phase in
            switch phase {
            case .empty:
                ProgressView() // Пока загружается
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Image(.mockEvent) // Фолбэк при ошибке
                    .resizable()
                    .scaledToFill()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: screenWidth * 0.7, height: screenWidth * 0.7 * 0.72)
        .clipped()
        .cornerRadius(screenWidth * 0.03)
        .overlay(
            HStack {
                dateView
                    .padding(.leading, screenWidth * 0.02)
                Spacer()
                bookmarkView
                    .padding(.trailing, screenWidth * 0.02)
            }
            .padding(.top, screenWidth * 0.02),
            alignment: .top
        )
    }



    var dateView: some View {
        VStack(spacing: screenWidth * 0.01) {
            Text(event.dates?.first?.day ?? "")
                .font(.system(size: screenWidth * 0.06, weight: .thin))
            
                
            Text(event.dates?.first?.month ?? "")
                .font(.system(size: screenWidth * 0.026, weight: .regular))
                
        }
        .foregroundColor(.red)
        .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
        .background(
            RoundedRectangle(cornerRadius: screenWidth * 0.02)
                .fill(Color.white.opacity(0.6))
        )
    }

    var bookmarkView: some View {
        Button {
            print("Bookmark tapped")
        } label: {
            Image(.bookmark2)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.045, height: screenWidth * 0.045)
                .padding(screenWidth * 0.025)
                .background(
                    RoundedRectangle(cornerRadius: screenWidth * 0.02)
                        .fill(Color.white.opacity(0.6))
                )
        }
        .buttonStyle(.plain)
        .offset(y: -screenWidth * 0.030)
    }
}


#Preview {
    ExploreImageView(event: .mockConcert)
        
}
