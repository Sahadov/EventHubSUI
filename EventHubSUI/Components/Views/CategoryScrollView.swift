//
//  CategoryScrollView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

enum CategoryScreenType {
    case explore, map
}

struct CategoryScrollView: View {
    var screenType: CategoryScreenType = .explore
    var onCategorySelected: ((EventCategory) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(EventCategory.allCases, id: \.self) { category in
                    CategoryButton(category: category, screenType: screenType) {
                        onCategorySelected?(category)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }
}

// MARK: - Subviews
struct CategoryButton: View {
    let category: EventCategory
    let screenType: CategoryScreenType
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: category.iconName)
                    .foregroundColor(screenType == .map ? category.color : .white)
                Text(category.title)
                    .foregroundColor(screenType == .map ? .gray : .white)
                    .bold()
                    .font(.Airbnb.medium(size: 13))
            }
            .frame(width: 107, height: 42)
            .minimumScaleFactor(0.2)
            .background(screenType == .map ? Color.white : category.color)
            .cornerRadius(21)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    CategoryScrollView()
}
