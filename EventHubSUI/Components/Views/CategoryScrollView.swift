//
//  CategoryScrollView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

enum categoyScreenType {
    case explore
    case map
}

struct CategoryScrollView: View {
    var screenType: categoyScreenType = .explore
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(EventCategory.allCases, id: \.self) { category in
                    Button {
                        // действие при нажатии
                        // реализовать callback
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: category.iconName)
                                .foregroundColor(screenType == .map ? category.color : Color.white)
                            Text(category.title)
                                .foregroundColor(screenType == .map ? .gray : Color.white)
                                .bold()
                                .font(.system(size: 13, weight: .bold))
                        }
                        .frame(width: 106.77, height: 39.06)
                        .minimumScaleFactor(0.2)
                        .background(screenType == .map ? Color.white : category.color)
                        .cornerRadius(20.96)
                        .shadow(radius: 2, y: 1)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }
}


#Preview {
    CategoryScrollView()
}
