//
//  SeeAllImage.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct SeeAllImage: View {
    let event: Event
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        AsyncImage(url: URL(string: event.displayImageURL ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Image(systemName: "photo") // фолбэк
                    .resizable()
                    .scaledToFill()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: screenWidth * 0.30, height: screenWidth * 0.35)
        .clipped()
        .cornerRadius(12)
    }
}



#Preview {
    SeeAllImage(event: .mockConcert)
}
