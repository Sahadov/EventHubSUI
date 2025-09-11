//
//  ExploreImageView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreImageView: View {
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        Image(.mockEvent)
            .resizable()
            .scaledToFill()
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
            Text("11")
                .font(.system(size: screenWidth * 0.05, weight: .bold))
            Text("June")
                .font(.system(size: screenWidth * 0.035))
        }
        .foregroundColor(.black)
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
    ExploreImageView()
}
