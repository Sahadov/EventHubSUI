//  ListCell.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//


import SwiftUI

struct ListCell: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок
            Text(event.displayTitle)
                .font(.headline)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Кнопка с NavigationLink
            HStack {
                if let urlString = event.place?.siteURL,
                   URL(string: urlString) != nil {
                    NavigationLink(destination: EventWebView(urlString: urlString)) {
                        CustomReadButtonView()
                    }
                } else {
                    CustomReadButtonView()
                        .opacity(0.6)
                        .onTapGesture {
                            print("NO VALID URL for event:", event.displayTitle)
                        }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}


struct CustomReadButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.accentBlue)
            .frame(width: 271, height: 58)
            .overlay(alignment: .center) {
                ZStack {
                    Text("READ")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .kerning(1)
                    Image(.rightArrow)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaledToFit()
                        .padding(.vertical, 14)
                        .offset(x: 110)
                }
                .foregroundStyle(.white)
            }
    }
}

#Preview {
    NavigationView {
        ListCell(event: .mockConcert)
    }
}
